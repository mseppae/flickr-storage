class Flickr::RakeHelper
  attr_accessor :client, :store, :statistics
  
  def initialize
    @client = Flickr::Client.new
    @store  = Flickr::Store.new
    @statistics = Flickr::Statistics.new(client)
  end
  
  def find_and_save_photos_by_username(username)
    user = client.find_by_username(username)
    unless user.nil?
      photos = user.public_photos
      save_photos(photos)
    end
    photos
  end
  
  def find_and_save_photos(options)
    photo_response = client.find_photos(options)
    save_photos(photo_response.photos)
    photo_response.photos
  end
  
  private
  
  def save_photos(photos)
    photos.each { |p| store.store_photo(p) }
    store.save_data
  end
  
  def save_user(user)
    store.store_user(user)
    store.save_data
  end
end