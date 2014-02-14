require 'nokogiri'
require 'open-uri'
require 'debugger'

  def get_fb_data(url)
    article_html = Nokogiri::HTML(open(url))
    likes_a = article_html.search(".pluginCountTextConnected")
    likes_b = article_html.search(".pluginCountTextDisconnected")
    likes_c = article_html.search(".pluginCountNum")
    likes_d = article_html.search(".pluginCountButton")
    debugger
    likes_e = article_html.search("#u_0_7")

    likes_css = article_html.css("#6a7180")

    article_xpath = Nokogiri::XML(open(url))
    likes_xpath = article_xpath.xpath('//*[@id="u_0_7"]/span[1]')
    
    shares = article_html.search(".num").children[0].text
    array = [likes_a, likes_b, likes_c, likes_d, likes_e, likes_css, likes_xpath, shares]
    debugger
    puts "hi"
  end

  puts get_fb_data("http://www.buzzfeed.com/miriamelder/13-gorgeous-pictures-of-russians-posing-with-their-cats")