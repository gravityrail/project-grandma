require 'spec_helper'

describe "videos/show.html.erb" do
  before(:each) do
    @video = assign(:video, stub_model(Video,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Thumbnail File Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Thumbnail Content Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Video File Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Video Content Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Job/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Encoded State/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Output Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Aspect Ratio/)
  end
end
