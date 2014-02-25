require 'bundler'
Bundler.require
require './lib/file'

class App < Sinatra::Application

  get '/' do
    erb :index
  end

  post '/result' do
    my_generator = Generator.new('./titles.txt')
    title = my_generator.sentence
    tgr = EngTagger.new
    tagged = tgr.add_tags(title.downcase)
    nouns_hash = tgr.get_nouns(tagged)
    gsub_out = nouns_hash.first[0].capitalize
    gsub_in = params["word"].capitalize
    @final_title = title.gsub(gsub_out, gsub_in)
  end
 
end



