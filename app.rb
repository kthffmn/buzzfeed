require 'bundler'
Bundler.require
require './lib/file'

class App < Sinatra::Application

  get '/' do
    haml :index
  end

  post '/result' do
    my_generator = Generator.new('./titles.txt')
    @title = my_generator.sentence
  end
 
end



