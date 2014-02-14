require 'nokogiri'
require 'open-uri'
require 'debugger'

class Scraper
	attr_accessor :array
  attr_reader :index_url

	def initialize(url)
		@array = []
		@index_url = url
	end

	def get_fb_data(article_url)
		article_html = Nokogiri::HTML(open(article_url))
    article_xpath = Nokogiri::XML(open(article_url))
    likes = article_xpath.xpath('//*[@id="u_0_7"]')
    shares = article_html.search(".num").children[0].text
    array = [likes, shares]
    debugger
    puts "hi"
	end

	def get_headlines_and_urls
		h2 = Nokogiri::HTML(open(index_url)).search("h2")
    counter = 0
		h2.each do |e|
			title = e.text
			items = /\A(\d+).*/.match(title)
			if items
        url = e.children[0].attributes["href"].value
        data = get_fb_data("http://www.buzzfeed.com" + url)
				array<< { :title => title,
									:items => items[1],
									:url => url,
									:likes => data[0],
                  :shares => data[1]
								}
        counter += 1
        puts "fetching likes: #{counter}"
				sleep(1)
			end
		end
		array
	end

end

my_scraper = Scraper.new('http://www.buzzfeed.com/index/paging?r=1&p=1')
puts my_scraper.get_headlines_and_urls.inspect
