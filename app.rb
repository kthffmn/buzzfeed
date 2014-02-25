require 'bundler'
Bundler.require
require './lib/generator'

class App < Sinatra::Application

  get '/' do
    haml :index
  end

  post '/result' do
    my_generator = Generator.new('./titles_two.txt', params["word"])
    @title = my_generator.user_title
    haml :result
  end
 
end



