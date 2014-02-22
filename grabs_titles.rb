
buzzfeed_array = [{:title=>"35 Nerdy Cards Against Humanity Cards To Add To Your Deck", :items=>"35", :url=>"http://www.buzzfeed.com/kmallikarjuna/nerdy-cards-against-humanity", :shares=>"4K"}, {:title=>"23-Year-Old Woman Grows Beard, Says She Feels More Feminine Than Ever", :items=>"23", :url=>"http://www.buzzfeed.com/alanwhite/23-year-old-woman-grows-beard-says-she-feels-more-feminine-t", :shares=>"230,361"}]

def create_array_of_titles(array)
  space_in_front = ""
  array.each |hash|
    space_in_front << " '" + hash[title] + "."
  end
  titles = space_in_front[1..-1]
end


create_array_of_titles(buzzfeed_array)