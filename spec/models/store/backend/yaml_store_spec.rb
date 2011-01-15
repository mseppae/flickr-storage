require File.dirname(__FILE__) + "/../../../spec_helper.rb"

describe Flickr::Store::Backend::YAML do
  TestRoot       = "storage/test"
  TestRootPhotos = "#{TestRoot}/photos.yml"
  TestRootUsers  = "#{TestRoot}/users.yml"
  attr_accessor :yaml_backend
  
  before do
    setup_test_files
    @yaml_backend = Flickr::Store::Backend::YAML.new(TestRoot)
  end
  
  it "should store photos to yaml file" do
    File.exists?(TestRootPhotos).should be_false
    yaml_backend.save_photos(SpecHelper.flickr_photo_array)
    File.exists?(TestRootPhotos).should be_true
  end
  
  it "should store users to yaml file" do
    File.exists?(TestRootUsers).should be_false
    yaml_backend.save_users([SpecHelper.user_mock])
    File.exists?(TestRootUsers).should be_true
  end
  
  it "should load photos from yaml file" do
    yaml_backend.save_photos(SpecHelper.flickr_photo_array)
    photos = yaml_backend.load_photos
    photos.count.should == 3
  end
  
  it "should return an empty array photo array if there is no yaml file to load" do
    photos = yaml_backend.load_photos
    photos.count.should == 0
  end
  
  it "should load users from yaml file" do
    yaml_backend.save_users([SpecHelper.user_mock])
    users = yaml_backend.load_users
    users.count.should == 1
  end
  
  it "should return an empty array for users if there is no yaml file" do
    users = yaml_backend.load_users
    users.count.should == 0
  end
  
  def setup_test_files    
    FileUtils.mkdir(TestRoot) unless File.exists?(TestRoot)
    FileUtils.rm(TestRootPhotos) if  File.exists?(TestRootPhotos)
    FileUtils.rm(TestRootUsers)  if  File.exists?(TestRootUsers)
  end
end