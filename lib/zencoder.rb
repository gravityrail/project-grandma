class Zencoder
  include HTTParty
  headers "Accept" => "application/json", "Content-Type" => "application/json"
  base_uri 'https://app.zencoder.com/api'
  default_params :api_key => "YOUR-API-KEY-GOES-HERE"
  format :json
  
  attr_accessor :job_id
  attr_reader :errors  
  attr_reader :output_url
  
  def initialize(encode_bucket_url = nil, notification_url = nil)
    @encode_bucket_url = encode_bucket_url
    @notification_url = notification_url
  end
  
  # encode a provided input_video at a given width and height, and dump the thumbnail into the thumbnail_destination
  # options: e.g. :test => 1
  def encode(input_video, width, height, thumbnail_destination, options = {})
    raise RuntimeError, "encode_bucket_url and/or notification_url is nil: you must set these to use this method." unless @encode_bucket_url && @notification_url
    query = {
      :input => input_video,
      :public => 1, # when set to 1, the encoded file will be publicly available, i.e. to web visitors 
      :outputs => { 
        :base_url => @encode_bucket_url,
        :size => "#{width}x#{height}",
        :public => 1,
        :notifications => [{
          :format => "json",
          :url => @notification_url
        }],
        :thumbnails => {
          :number => 1,
          :base_url => @encode_bucket_url + thumbnail_destination,
          :size => "#{width}x#{height}"
        }
      }
    }.merge(options)
    job = self.class.post("/jobs", :body => query.to_json)
    if job["errors"]
      errors = job["errors"]
      false
    else
      @output_url = job["outputs"].first["url"]
      @job_id = job["id"]
      job
    end
  end
  
  # get details about a job. You may pass a job_id or if none is provided, this will use @job_id if it is available
  def details(job_id = nil)
    @job_id ||= job_id
    if @job_id
      self.class.get("/jobs/#{@job_id}")
    else
      raise RuntimeError, "@job_id is nil: you must set the job id, pass the job id, or encode a job (which sets it automatically) to use this method."
    end
  end
  
end