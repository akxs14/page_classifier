# encoding: utf-8

require 'nokogiri'

class HtmlParser

  def initialize

  end

  def parse_pages page_bodies

  end

  def extract_text crawled_page
    doc = Nokogiri::HTML(crawled_page)
    links = doc.css("a").text
  end

end
