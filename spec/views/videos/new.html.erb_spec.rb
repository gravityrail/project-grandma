require 'spec_helper'

describe "videos/new.html.erb" do
  before(:each) do
    assign(:video, stub_model(Video,
      :title => "MyString",
      :description => "MyText",
      :owner_id => 1,
      :thumbnail_file_name => "MyString",
      :thumbnail_content_type => "MyString",
      :thumbnail_file_size => 1,
      :video_file_name => "MyString",
      :video_content_type => "MyString",
      :video_file_size => 1,
      :job_id => "MyString",
      :encoded_state => "MyString",
      :output_url => "MyString",
      :duration_in_ms => 1,
      :aspect_ratio => "MyString"
    ).as_new_record)
  end

  it "renders new video form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => videos_path, :method => "post" do
      assert_select "input#video_title", :name => "video[title]"
      assert_select "textarea#video_description", :name => "video[description]"
      assert_select "input#video_owner_id", :name => "video[owner_id]"
      assert_select "input#video_thumbnail_file_name", :name => "video[thumbnail_file_name]"
      assert_select "input#video_thumbnail_content_type", :name => "video[thumbnail_content_type]"
      assert_select "input#video_thumbnail_file_size", :name => "video[thumbnail_file_size]"
      assert_select "input#video_video_file_name", :name => "video[video_file_name]"
      assert_select "input#video_video_content_type", :name => "video[video_content_type]"
      assert_select "input#video_video_file_size", :name => "video[video_file_size]"
      assert_select "input#video_job_id", :name => "video[job_id]"
      assert_select "input#video_encoded_state", :name => "video[encoded_state]"
      assert_select "input#video_output_url", :name => "video[output_url]"
      assert_select "input#video_duration_in_ms", :name => "video[duration_in_ms]"
      assert_select "input#video_aspect_ratio", :name => "video[aspect_ratio]"
    end
  end
end
