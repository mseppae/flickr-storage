require File.dirname(__FILE__) + "/../../spec_helper.rb"

describe Flickr::Store::Base do
  attr_accessor :store
  
  before do
    @store = Flickr::Store.new
  end
  
  it "should default to YAML storage_backend" do
    store.storage_backend.class.should eq(Flickr::Store::Backend::YAML)
  end
  
  it "should find user from store with user_id" do
    store_cool_user
    user = store.find_user(:user_id => SpecHelper.userID)
    user.username.should == SpecHelper.username
  end

  it "should find user from store with username" do
    store_cool_user
    user = store.find_user(:username => SpecHelper.username)
    user.nsid.should == SpecHelper.userID
  end
  
  it "should store a user" do
    store.users.count.should == 0
    store.store_user(SpecHelper.user_mock)
    store.users.count.should == 1
  end

  it "should only accept Flickr::People::Person type of users" do
    store.users.count.should == 0
    store.store_user("Mike")
    store.users.count.should == 0
  end

  it "should not store duplicate user" do
    store_cool_user
    store.store_user(SpecHelper.user_mock)
    store.users.count.should == 1
  end

  it "should store photo" do
    store.photos.count.should == 0
    store.store_photo(SpecHelper.photo_mock)
    store.photos.count.should == 1
  end

  it "should only accept Flickr::Photos::Photo type of photos" do
    store.users.count.should == 0
    store.store_user("photo")
    store.users.count.should == 0
  end

  it "should not store duplicate photo" do
    store_photo
    store.store_photo(SpecHelper.photo_mock)
    store.photos.count.should == 1
  end

  it "should update local photo if its timestamp has changed" do
    store_photo_with_time(Time.mktime(2000, 1, 1))
    # We need to renew the instance of this photo, otherwise we also change the photo
    # that is already in the store.
    photo = SpecHelper.photo_mock
    photo.title = 'updated title'
    photo.updated_at = Time.now
    store.store_photo(photo)
    store.photos[photo.id].title.should == 'updated title'
  end

  it "should not update local photo if its timestamp has not changed" do
    store_photo_with_time(Time.now)
    # We need to renew the instance of this photo, otherwise we also change the photo
    # that is already in the store.
    photo = SpecHelper.photo_mock
    photo.title = 'updated title'
    photo.updated_at = Time.mktime(2000, 1, 1)
    store.store_photo(photo)
    store.photos[photo.id].title.should_not == 'updated title'
  end
  
  it "should delegate saving to storage_backend" do
    storage_backend = store.storage_backend
    storage_backend.should_receive(:save_users).once
    storage_backend.should_receive(:save_photos).once
    store.save_data
  end

  it "should delegate loading to storage_backend" do
    storage_backend = store.storage_backend
    storage_backend.should_receive(:load_users).once { [] }
    storage_backend.should_receive(:load_photos).once { [] }
    store.load_data
  end
  
  def store_cool_user
    user = SpecHelper.user_mock
    store.store_user(user)
  end
  
  def store_photo
    photo = SpecHelper.photo_mock
    store.store_photo(photo)
  end
  
  def store_photo_with_time(time)
    photo = SpecHelper.photo_mock
    photo.updated_at = time
    store.store_photo(photo)
  end
end