class StoriesController < ApplicationController
  #prepend_before_filter :require_no_authentication, :only => [ :encode_notify ]
  #prepend_before_filter :authenticate_scope!, :only => [:index, :show, :edit, :create, :update, :destroy]
  #before_filter :authenticate_user!
  #before_filter :require_no_authentication, :only => 'encode_notify'
  protect_from_forgery :except => [:encode_notify]

  def encode_notify
    # get the job id so we can find the video
    if(params[:job])
      video = VideoFile.find_by_job_id(params[:job][:id].to_i)
      Story.capture_notification(params[:output]) if video
    end
    render :text => "Thanks, Zencoder!", :status => 200
  end
  
  def add_files
    @story = Story.find(params[:id])
  end
  
  #rpc call from file uploader
  def add_file_to_story
    @story = Story.find(params[:id])
    
    url = params[:url]
    name = params[:name]
    
    VideoFile file = VideoFile.new(:url => url, :name => name)
    
    @story.add_and_encode(file)
    
  end

  # GET /videos
  # GET /videos.xml
  def index
    @stories = Story.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end
  
  # render XML manifest describing the annotations for this video
  def manifest
    @story = Story.find(params[:id])
    
    respond_to do |format|
      format.xml { render :xml => @stories }
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /videos/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /videos
  # POST /videos.xml
  def create
    @story = Story.new(params[:story])
    
    if(current_user)
      @story.owner_id = current_user.id
    end
    
    RAILS_ENV == "production" ? test = {} : test = {:test => 1}
    if @story.save# && @story.encode!(test)
      #render :json => {:message => "Video was successfully uploaded.  Encoding has commenced automatically."}
      flash[:notify] = 'Created Story' 
      redirect_to add_files_url(@story.id)
    else
      flash[:errors] = 'Errors: '+@story.errors.full_messages.to_sentence.capitalize
      render :action => 'new'
    end
  
#     respond_to do |format|
#       if @story.save
#         format.html { redirect_to(@story, :notice => 'Video was successfully created.') }
#         format.xml  { render :xml => @story, :status => :created, :location => @story }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
#       end
#     end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to(@story, :notice => 'Story was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(stories_url) }
      format.xml  { head :ok }
    end
  end
end
