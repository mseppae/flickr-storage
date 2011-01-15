require 'rake'

namespace :photos do
  desc "Searches users public photos and saves them to YAML file.
  Example: rake photos:save_by_user USER=mseppae"
  task :save_by_user do
    username = ENV['USER'] ? ENV['USER'] : raise("Username must be supplied with USER=username.")
    Rake::Task['load_environment'].invoke

    rake_helper = Flickr::RakeHelper.new
    begin
      rake_helper.find_and_save_photos_by_username(username)
    rescue Exception => e
      puts "Photo saving for #{username} failed with following message: "
      puts e.message
    end
  end
  
  desc "Searches photos by text query string and save them to YAML file.
  Example: rake photos:save_by_query KEY=tags VALUE=party-san"
  task :save_by_query do
    key   = ENV['KEY'] ? ENV['KEY'] : raise("KEY must be given for photo search.")
    value = ENV['VALUE'] ? ENV['VALUE'] : raise("VALUE must be given for photo search.")
    Rake::Task['load_environment'].invoke

    rake_helper = Flickr::RakeHelper.new
    begin
      rake_helper.find_and_save_photos(key => value)
    rescue Exception => e
      puts "Photo saving for '#{key} => #{value}' failed with following message: "
      puts e.message
    end
  end
end

namespace :user do
  namespace :photos do
    desc "Aggregates over users photo views and returns total amount of views.
    Example: rake user:photos:total_views USER=mseppae"
    task :total_views do
      username = ENV['USER'] ? ENV['USER'] : raise("Username must be supplied with USER=username.")
      Rake::Task['load_environment'].invoke
      rake_helper = Flickr::RakeHelper.new

      begin
        views = rake_helper.statistics.total_user_photo_hits(username)
        puts "User #{username} has total amount of #{views} photo views"
      rescue Exception => e
        puts "Statistics for #{username} failed with following message: "
        puts e.message
      end
    end
  end
end

task :load_environment do
  require File.join(File.dirname(__FILE__), 'lib', 'flickr_storage.rb')
end

