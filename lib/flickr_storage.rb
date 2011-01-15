require 'rubygems'
require 'flickr_fu'
require 'logger'

begin
  FlickrLogger
rescue
  FlickrLogger = Logger.new(File.join('logs', 'flickr.log'))
end

%w{client statistics}.each do |file|
  require File.join(File.dirname(__FILE__), 'flickr', file)
end

require File.join(File.dirname(__FILE__), 'flickr', 'store', 'base')

# Backend storages
%w{ yaml }.each do |file|
  require File.join(File.dirname(__FILE__), 'flickr', 'store', 'backend', file)
end

require File.join(File.dirname(__FILE__), '/../', 'rake', 'rake_helper')