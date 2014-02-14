require 'nokogiri'
require 'open-uri'

class Buzzfeed
    attr_reader :regex, :url
    attr_accessor :data

    def initialize
        @url = 'http://www.buzzfeed.com/index/paging?r=1&p='
        @data = []
    end

    def scraper(url)
        html = Nokogiri::HTML(open(url))
    end

    def counter
        counter = 1
        while counter < 3738
            scraper("#{@url}" + "counter")
            counter += 1
            sleep(1)
        end
    end

end


