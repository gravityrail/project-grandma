require 'spec_helper'

describe "videos/index.html.erb" do
  before(:each) do
    assign(:videos, [
      stub_model(Video,
        :title => "Title",
        :description => "MyText",
        :owner_id => 1,
        :thumbnail_file_name => "Thumbnail File Name",
        :thumbnail_content_type => "Thumbnail Content Type",
        :thumbnail_file_size => 1,
        :video_file_name => "Video File Name",
        :video_content_type => "Video Content Type",
        :video_file_size => 1,
        :job_id => "Job",
        :encoded_state => "Encoded State",
        :output_url => "Output Url",
        :duration_in_ms => 1,
        :aspect_ratio => "Aspect Ratio"
      ),
      stub_model(Video,
        :title => "Title",
        :description => "MyText",
        :owner_id => 1,
        :thumbnail_file_name => "Thumbnail File Name",
        :thumbnail_content_type => "Thumbnail Content Type",
        :thumbnail_file_size => 1,
        :video_file_name => "Video File Name",
        :video_content_type => "Video Content Type",
        :video_file_size => 1,
        :job_id => "Job",
        :encoded_state => "Encoded State",
        :output_url => "Output Url",
        :duration_in_ms => 1,
        :aspect_ratio => "Aspect Ratio"
      )
    ])
  end

  it "renders a list of videos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Thumbnail File Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Thumbnail Content Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Video File Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Video Content Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Job".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Encoded State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Output Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Aspect Ratio".to_s, :count => 2
  end
end
