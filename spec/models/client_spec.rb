require File.dirname(__FILE__) + "/../spec_helper.rb"

describe Flickr::Client do
  attr_accessor :flickr_client, :flickr
  
  before do
    @flickr_client = Flickr::Client.new()
    @flickr = flickr_client.send(:flickr)
  end
  
  it "should be able to search photos (using flickr-fu api)" do
    flickr_photos = flickr.photos
    flickr_photos.should_receive(:search).with({:text => 'party-san', :media => 'photo'})
    flickr_client.find_photos(:text => 'party-san')
  end

  it "should be able to search people with id (using flickr-fu api)" do
    flickr_people = flickr.people
    flickr_people.should_receive(:find_by_id).with(SpecHelper.userID)
    flickr_client.find_by_userid(SpecHelper.userID)
  end

  it "should be able to search people with usernam (using flickr-fu api)" do
    flickr_people = flickr.people
    flickr_people.should_receive(:find_by_username).with(SpecHelper.username)
    flickr_client.find_by_username(SpecHelper.username)
  end
end