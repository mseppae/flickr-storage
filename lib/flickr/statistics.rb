class Flickr::Statistics
  
  def initialize(client = Flickr::Client.new())
    @client = client
  end
  
  def total_user_photo_hits(username)
    user = client.find_by_username(username)
    unless user.nil?
      return user.public_photos.inject(0) { |total, photo| total += photo.views.to_i }
    end
  end
  
  private
  attr_accessor :client
end