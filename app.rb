require 'bundler'
Bundler.require
require './lib/file'

class App < Sinatra::Application

  get '/' do
    haml :index
  end
 
end



