class Flickr::Client
  def initialize
    @flickr = Flickr.new(File.join("config", "flickr.yml"))
  end
  
  def find_by_username(username)
    begin
      flickr.people.find_by_username(username)
    rescue Exception => e
      FlickrLogger.info("Flickr::Client#find_by_username username: #{username}. " + e.message)
      raise e
    end
  end
  
  def find_by_userid(userid)
    begin
      flickr.people.find_by_id(userid)
    rescue Exception => e
      FlickrLogger.info("Flickr::Client#find_by_userid user_id: #{userid}. " + e.message)
      raise e
    end
  end
  
  def find_photos(options)
    options.merge!(:media => 'photo')
    begin
      flickr.photos.search(options)
    rescue Exception => e
      FlickrLogger.info("Flickr::Client#find_photos. " + e.message)
      raise e
    end
  end
  
  private
  attr_accessor :flickr
end