require 'bundler'
Bundler.require
require './lib/file'

class App < Sinatra::Application

  get '/' do
    haml :index
  end

  post '/result' do
    my_generator = Generator.new('./titles.txt', params["word"])
    @title = my_generator.user_title
    haml :result
  end
 
end



