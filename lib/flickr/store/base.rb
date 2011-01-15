module Flickr
  module Store
    
    class << self
      def new(backend = Flickr::Store::Backend::YAML.new)
        Base.new(backend)
      end
    end
    
    class Base
      attr_accessor :storage_backend, :users, :photos

      def initialize(backend)
        @storage_backend  = backend
        @users, @photos = {}, {}
      end
      
      def find_user(options)
        return users[options[:user_id]] if options[:user_id]
        users.each_value { |v| return v if v.username == options[:username] }
      end
      
      def store_user(user)
        if user.instance_of?(Flickr::People::Person)
          users[user.nsid] = user unless users.has_key?(user.nsid)
        end
      end
      
      def store_photo(photo)
        if photo.instance_of?(Flickr::Photos::Photo)
          if photos.has_key?(photo.id)
            if photos[photo.id].updated_at < photo.updated_at
              photo.send(:attach_info)
              photos[photo.id] = photo
            end
          else
            photo.send(:attach_info)  # Description is not automatically loaded
            photos[photo.id] = photo
          end
        end
      end
      
      def load_data
        storage_backend.load_users.each  { |u| store_user(u) }
        storage_backend.load_photos.each { |p| store_photo(p) }
      end
      
      def save_data
        storage_backend.save_users(users.values)
        storage_backend.save_photos(photos.values)
      end
    end
  end
end