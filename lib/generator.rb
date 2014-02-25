require 'marky_markov'

class Generator
  ARRAY = ["Ways To", "Reasons To", "Things To", "", "Things", "Ways"]
  attr_reader :markov, :word, :tgr

  def initialize(text_file, word)
    file = File.new("#{text_file}", "r")
    @markov = MarkyMarkov::Dictionary.new('dictionary', 2)
    @markov.parse_file file
    @word = word
    @tgr = EngTagger.new
  end

  def marky_title
    sentence = rand(1..36).to_s + " " + ARRAY.sample + " " + @markov.generate_1_sentences
    sentence.gsub("  ", " ")
  end

  def user_title
    title = marky_title
    tagged = tgr.add_tags(title.downcase)
    nouns_hash = tgr.get_nouns(tagged)
    gsub_out = nouns_hash.first[0].capitalize
    gsub_in = params["word"].capitalize
    @final_title = title.gsub(gsub_out, gsub_in)
  end

end



    title = my_generator.sentence
    tgr = EngTagger.new
    tagged = tgr.add_tags(title.downcase)
    nouns_hash = tgr.get_nouns(tagged)
    gsub_out = nouns_hash.first[0].capitalize
    gsub_in = params["word"].capitalize
    @final_title = title.gsub(gsub_out, gsub_in)
