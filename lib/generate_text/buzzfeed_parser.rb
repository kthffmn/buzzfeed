require 'csv'
require 'awesome_print'
require 'debugger'

class CSVParser
  attr_accessor :output
  attr_reader :column_names, :data_rows

  def initialize(path_to_tsv)
    @data_rows = CSV.read(path_to_tsv, { :col_sep => "\t" })
    @column_names = [:num, :title, :url] # [Timestamp, Date, ...]
    @output = []
  end

  def parse
    data_rows.each do |row|
      hash = {}  
      row.each_with_index do |attribute, i|
        hash[column_names[i]] = attribute
      end
      output << hash
    end
    output
  end

  def textify
    text = ""
    parse.each do |hash|
      text << " #{hash[:title]}."
    end
    text.gsub("&nbsp;", " ")
        .gsub('&#8212;', '—')
        .gsub('&mdash;', '—')
        .gsub('&ndash;', "-") 
        .gsub("&#8217;", "'")
        .gsub('&#8220;', '"')
        .gsub('&#8221;', '"')
        .gsub('&#8216;', "'")
        .gsub('&#8230;', "...")
        .gsub('&hellip;', "...")
        .gsub('&quot;', '"')
        .gsub('&amp;', "&")
        .gsub('&deg;', '°')
        .gsub('&gt;', '>')
        .gsub('&lt;', '<')
        .gsub('&eacute', "é")
        .gsub('&oacute;', 'ó')
        .gsub('&iacute;', 'í')
        .gsub('&ntilde;', 'ñ')
        .gsub('&aacute;', 'á')
        .gsub('&auml;', 'ä')
        .gsub('&uuml;', 'ü')
        .gsub('&ouml;', 'ö')
        .gsub('&trade;', '™')
        .gsub('&copy;', '©')
        .gsub('&ldquo;', '"')
        .gsub('&rdquo;', "'")
        .gsub('&lsquo;', "'")
        .gsub('&rsquo;', "'")
  end

end

my_parser = CSVParser.new('crawl.tsv')
print my_parser.textify
