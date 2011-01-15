require 'rubygems'
require 'rspec'
require 'fileutils'

require File.dirname(__FILE__) + "/../lib/flickr_storage.rb"

class SpecHelper
  class << self
    def userID
      "58187635@N07"
    end
    
    def username
      "mseppae"
    end
    
    def user_mock
      Flickr::People::Person.new("Flickr instance", { :nsid => userID, :username => username })
    end
    
    def photo_mock
      photo = Flickr::Photos::Photo.new("Flickr instance", :id => 1, :owner => userID,
              :title => "photo",  :views => "12", :updated_at => Time.mktime(1970, 1, 1))
      photo.stub(:attach_info)
      photo
    end
    
    def flickr_photo_array
      [Flickr::Photos::Photo.new("Flickr instance", :id => 2, :owner => userID, :title => "first",  :views => "20"),
       Flickr::Photos::Photo.new("Flickr instance", :id => 3, :owner => userID, :title => "second", :views => "30"),
       Flickr::Photos::Photo.new("Flickr instance", :id => 4, :owner => userID, :title => "third",  :views => "50")]
    end
  end
end
