require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :array, :inaccessible
  attr_reader :url, :agent

  def initialize
    @array = []
    @url = 'http://www.buzzfeed.com/index/paging?r=1&p='
    @inaccessible = []
  end

  def get_fb_shares(article_url)
    puts article_url
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
      the_items = /The (\d+).*/.match(title)
      if title != '\n\t\t\t\t\n\t\t\t\t\tThe 7 Most Terrifying Archaeological Discoveries\n\t\t\t\t\t cracked.com\n\t\t\t\t\n\t\t\t' 
        if items || the_items
          print title
          if items
            num = items[1]
          else
            num = the_items[1]
          end
          url = 'http://www.buzzfeed.com' + e.children[0].attributes['href'].value
          if url == 'http://www.buzzfeed.com/video/robinedds/types-of-troll-youll-meet-on-the-internet'
            url = 'http://www.buzzfeed.com/robinedds/types-of-troll-youll-meet-on-the-internet'
          end
          array << {:title => title, :items => num, :url => url, :shares => get_fb_shares(url)}
          counter += 1
          puts counter.to_s
        end
      end
    array
    end
  end

  def increment
    counter = 1525
    while counter < 3744
      puts 'index: ' + counter.to_s
      get_data(url + counter.to_s)
      if counter % 25 == 0
        puts array.inspect
      end
      counter += 1
    end
    if inaccessible.length >= 0
      array
    else
      [array, inaccessible]
    end
  end

end

my_scraper = Scraper.new
puts my_scraper.increment.inspect
