class Story < ActiveRecord::Base
  #validates_presence_of :title
  
  scope :finished, :conditions => { :encoded_state => "finished" }
  
  belongs_to :owner, :class_name=>User

  has_many :video_files
  
  #attr_accessible :video, :title, :description, :thumbnail
  
  # has_attached_file :video, 
#     :url => ":class/:id/:style/:basename.:extension",
#     :path => ":class/:id/:style/:basename.:extension",
#     :storage => :s3 # this is redundant if you are using S3 for all your storage requirements
  
  #process_in_background :video
  
  #validates_attachment_presence :video
  
  has_attached_file :thumbnail, :styles => {:thumb => "162x161#"} # adjust the thumb style as needed
  
  after_destroy :remove_encoded_videos
  
  # this runs on the after_destroy callback.  It is reponsible for removing the encoded file
  # and the thumbnail that is associated with this video.  Paperclip will automatically remove the other files, but
  # since we created our own bucket for encoded video, we need to handle this part ourselves.
  def remove_encoded_videos
    video_files.each do |videofile|
    
      unless videofile.url.blank?
      
#        AWS::S3::Base.establish_connection!(
#          :access_key_id     => zencoder_setting["s3_output"]["access_key_id"],
#          :secret_access_key => zencoder_setting["s3_output"]["secret_access_key"]
#        )
#        AWS::S3::S3Object.delete(File.basename(output_url), zencoder_setting["s3_output"]["bucket"])
        # there is no real concept of folders in S3, they are just labels, essentially
#        AWS::S3::S3Object.delete("/thumbnails_#{self.id}/frame_0000.png", zencoder_setting["s3_output"]["bucket"])
        
        #XXX TODO remove transcoded files!
        
      end
      
    end
  end
  
  def add_and_encode(videofile)
    self.video_files << videofile
    self.encode!(videofile) # notifies zencoder to start transcoding the file
  end

  
  
  # commence encoding of the video.  Width and height are hard-coded into this, but there may be situations where
  # you want that to be more dynamic - that modification will be trivial.
  def encode!(videofile)
    begin

      #output_filename = "s3://#{ZENCODER_CONFIG['bucket']}/#{File.basename(self.video.name)}.webm"
      
      logger.warn "Transcoding '#{videofile.url}'"
    
      response = Zencoder::Job.create({
        :input => videofile.url,
        :output => {
          :width => "480",
          :height => "320",
          #:url => output_filename,
          :notification => ZENCODER_CONFIG['notification_url']
        }
      })
      
      logger.warn 'Response: '+response.raw_response
      
      if(response.success?)
        self.encoded_state = "queued"
        self.output_url = response.body["outputs"].first["url"]
        self.job_id = response.body['id']
      else
        errors.add_to_base(response.raw_response)
      end  
      
#       zen = Zencoder.new("http://s3.amazonaws.com/" + zencoder_setting["s3_output"]["bucket"], zencoder_setting["settings"]["notification_url"])
#       # 'video.url(:original, false)' prevents paperclip from adding timestamp, which causes errors
#       if zen.encode(self.video.url(:original, false), 800, 450, "/thumbnails_#{self.id}", options)
#         self.encoded_state = "queued"
#         self.output_url = zen.output_url
#         self.job_id = zen.job_id
#         self.save
#       else
#         errors.add_to_base(zen.errors)
#         nil
#       end
    rescue RuntimeError => exception
      errors.add_to_base("Video encoding request failed with result: " + exception.to_s)
      nil
    end
  end
  
  # must be called from a controller action, in this case, videos/encode_notify, that will capture the post params
  # and send them in.  This captures a successful encoding and sets the encode_state to "finished", so that our application
  # knows we're good to go.  It also retrieves the thumbnail image that Zencoder creates and attaches it to the video
  # using Paperclip.  And finally, it retrieves the duration of the video, again from Zencoder.
  def capture_notification(output)
    self.encoded_state = output[:job][:state]
    if self.encoded_state == "finished"
      self.output_url = output[:url]
      self.thumbnail = open(URI.parse("http://s3.amazonaws.com/" + ZENCODER_CONFIG['bucket'] + "/thumbnails_#{self.id}/frame_0000.png"))
      self.thumbnail_content_type = "image/png"
      # get the job details so we can retrieve the length of the video in milliseconds
#       zen = Zencoder.new
      self.duration_in_ms = Zencoder::Job.details(self.job_id)['job']['output_media_files'].first['duration_in_ms'] #zen.details(self.job_id)["job"]["output_media_files"].first["duration_in_ms"]
    end
    
    
    
    self.save
  end
  
  # a handy way to turn duration_in_ms into a formatted string like 5:34
  def human_length
    if duration_in_ms
      minutes = duration_in_ms / 1000 / 60
      seconds = (duration_in_ms / 1000) - (minutes * 60)
      sprintf("%d:%02d", minutes, seconds)
    else
      "Unknown"
    end
  end
  
  private
    
    def zencoder_setting
      @zencoder_config ||= YAML.load_file("#{RAILS_ROOT}/config/zencoder.yml")
    end
  
end
