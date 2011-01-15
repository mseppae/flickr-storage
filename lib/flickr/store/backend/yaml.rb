module Flickr
  module Store
    module Backend
      class YAML
        attr_accessor :root_dir
      
        def initialize(dir = "storage")
          FileUtils.mkdir_p(dir) unless File.exists?(dir)
          @root_dir = dir
        end
      
        def save_users(users = [])
          return users if users.empty?
          File.open("#{root_dir}/users.yml", "w") do |f|
            f.puts users.to_yaml
          end
        end
      
        def save_photos(photos = [])
          return photos if photos.empty?
          File.open("#{root_dir}/photos.yml", "w") do |f|
            f.puts photos.to_yaml
          end
        end

        def load_users
          if File.exists?("#{root_dir}/users.yml")
            ::YAML.load_file("#{root_dir}/users.yml")
          else
            []
          end
        end
      
        def load_photos
          if File.exists?("#{root_dir}/photos.yml")
            ::YAML.load_file("#{root_dir}/photos.yml")
          else
            []
          end
        end
      end
    end
  end
end