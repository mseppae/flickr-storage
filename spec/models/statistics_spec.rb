require File.dirname(__FILE__) + "/../spec_helper.rb"

describe Flickr::Statistics do
  attr_accessor :statistics, :client
  
  before do
    @statistics = Flickr::Statistics.new
    @client = statistics.send(:client)
  end
  
  it "should give total amount of views of all the public photos user has uploaded" do
    flickr_person = SpecHelper.user_mock
    flickr_person.should_receive(:public_photos) { SpecHelper.flickr_photo_array }
    client.should_receive(:find_by_username).with(SpecHelper.username) { flickr_person }
    
    aggregated_views = statistics.total_user_photo_hits(SpecHelper.username)
    aggregated_views.should == 100
  end
end