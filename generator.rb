require 'marky_markov'
require './titles.txt'

class Generator
  ARRAY = ["ways to", "reasons to", "things to"]

  attr_reader :markov
  def initialize
    markov = MarkyMarkov::Dictionary.new('dictionary', 1)
    markov.parse_file "titles.txt"
  end

  def sentence
    rand(1..36) + ARRAY.sample + markov.generate_1_sentences
  end

end

my_generator = Generator.new
puts my_generator.sentence.inspect
