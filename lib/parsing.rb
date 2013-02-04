require 'rubygems'
require 'nokogiri'
require 'open-uri'

module Events
  class Parsing
    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
    end

    def parse_from_url
      @doc.xpath('//span[@class="method-name"]').each do | method_span |
          puts method_span.content
          puts method_span.path
          puts
      end
    end
  end
end
