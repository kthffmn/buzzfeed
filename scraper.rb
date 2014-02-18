require 'nokogiri'
require 'open-uri'

class Scraper
	attr_accessor :array
  attr_reader :url, :agent

	def initialize
		@array = []
		@url = 'http://www.buzzfeed.com/index/paging?r=1&p='
    @inaccessible = []
	end

	def get_fb_shares(article_url)
    html = Nokogiri::HTML(open(article_url))
    num = html.search('.num').children[0]
    if num
      num.text
    else
      inaccessible << article_url
      'inaccessible'
    end
	end

	def get_data(index_url)
		h2 = Nokogiri::HTML(open(index_url)).search('h2')
    counter = 0
		h2.each do |e|
			title = e.text
			items = /\A(\d+).*/.match(title)
			if items
        url = 'http://www.buzzfeed.com' + e.children[0].attributes['href'].value
				array << {:title => title,
									:items => items[1],
									:url => url,
                  :shares => get_fb_shares(url)
								}
        counter += 1
        puts counter.to_s
			end
		end
		array
	end

  def increment
    counter = 1
    while counter < 3744
      puts 'index: ' + counter.to_s
      get_data(url + counter.to_s)
      if counter % 25 == 0
        puts array.inspect
      end
      counter += 1
    end
    [array, inaccessible]
  end

end

my_scraper = Scraper.new
puts my_scraper.increment.inspect
