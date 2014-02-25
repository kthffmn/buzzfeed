require 'marky_markov'

class Generator
  ARRAY = ["Ways To", "Reasons To", "Things To", "", "Things", "Ways"]
  attr_reader :markov

  def initialize(text_file)
    file = File.new("#{text_file}", "r")
    @markov = MarkyMarkov::Dictionary.new('dictionary', 2)
    @markov.parse_file file
  end

  def sentence
    sentence = rand(1..36).to_s + " " + ARRAY.sample + " " + @markov.generate_1_sentences
    sentence.gsub("  ", " ")
  end

end
