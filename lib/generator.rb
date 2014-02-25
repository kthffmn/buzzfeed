class Generator
  ARRAY = ["Ways To", "Reasons To", "Things To", "", "Things", "Ways"]
  attr_reader :markov, :word, :tgr

  def initialize(text_file, word)
    file = File.new("./public/#{text_file}", "r")
    @markov = MarkyMarkov::Dictionary.new('dictionary', 2)
    @markov.parse_file file
    @word = word.capitalize
    @tgr = EngTagger.new
  end

  def marky_title
    # sentence = rand(1..36).to_s + " " + ARRAY.sample + " " + @markov.generate_1_sentences
    # sentence.gsub("  ", " ")
    @markov.generate_1_sentences
  end

  def user_title
    tagged = tgr.add_tags(marky_title.downcase)
    nouns_hash = tgr.get_nouns(tagged)
    gsub_out = nouns_hash.first[0].capitalize
    marky_title.gsub(gsub_out, word)
  end

end