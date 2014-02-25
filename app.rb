require 'bundler'
Bundler.require
require './lib/file'

class App < Sinatra::Application

  get '/' do
    haml :index
  end

  post '/result' do
    my_generator = Generator.new('./titles.txt')
    title = my_generator.sentence
    tgr = EngTagger.new
    text = title
    tagged = tgr.add_tags(text)
    nouns_hash = tgr.get_nouns(tagged)
    gsub_out = nouns_hash.first[0]
    gsub_in = params["word"]
    @final_title = title.gsub(gsub_out, gsub_in)
  end
 
end



