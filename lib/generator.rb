class Generator
  attr_reader :markov, :word, :tgr, :marky_title, :in_ends_in_s

  def initialize(text_file, word)
    file = File.new("./public/#{text_file}", "r")
    markov = MarkyMarkov::Dictionary.new('dictionary', 2)
    markov.parse_file file
    @marky_title = markov.generate_1_sentences
    @word = word.capitalize
    @in_ends_in_s = (@word[-1] == "s")
  end

  def user_title
    title = ""
    10.times do 
      tgr = EngTagger.new
      tagged = tgr.add_tags(marky_title.downcase)
      nouns_hash = tgr.get_nouns(tagged)
      if nouns_hash.length > 0
        gsub_out = nouns_hash.first[0].capitalize
        out_ends_in_s = (gsub_out[-1] == "s")
        if out_ends_in_s == in_ends_in_s
          title = marky_title.gsub(gsub_out, word)
        elsif out_ends_in_s && !in_ends_in_s
          final_word = word + "s"
          title = marky_title.gsub(gsub_out, final_word)
        else                                              # !out_ends_in_s && in_ends_in_s 
          final_word = word[0...-1]
          title = marky_title.gsub(gsub_out, final_word)
        end
        break
      end
    end
    title[0...-1]
  end

end