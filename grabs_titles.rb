
def create_array_of_titles(array)
  space_in_front = ""
  array.each do |hash|
    space_in_front << " '" + hash[:title] + "."
  end
  titles = space_in_front[1..-1]
end

puts create_array_of_titles(buzzfeed_array).inspect

