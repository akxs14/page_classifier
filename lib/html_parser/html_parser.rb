# encoding: utf-8

require 'nokogiri'

class HtmlParser

  def parse_pages crawled_pages
    parsed_pages = {}
    crawled_pages.each do |url, page_body|
      parsed_pages[url] = {
        :significant_terms => extract_related_text(page_body),
        :body_terms => extract_text(page_body)
      }
    end
    parsed_pages
  end

  def extract_related_text crawled_page
    doc = Nokogiri::HTML(crawled_page)
    title = doc.css('title').text
    meta_description = doc.xpath('//meta[@name="keywords"]/@content').map(&:value)
    [title,meta_description].map {|tag_group| parse_line(tag_group)}.flatten
  end

  def extract_text crawled_page
    doc = Nokogiri::HTML(crawled_page)
    links = doc.css("a").text
    paragraphs = doc.css("p").text
    [links,paragraphs].map {|tag_group| parse_line(tag_group)}.flatten
  end

  #parses lines which are string or split into sentences stored in an array.
  def parse_line line
    if line.class == Array
      words = []
      line.each {|sentence| words << discard_useless_strings(split_sentence(sentence)) }
    else
      discard_useless_strings(split_sentence(line))
    end
  end

  def discard_useless_strings tokens_array
    tokens_array.delete_if do |item|
      item.length < 3 or
      (item.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true )
    end
  end

  def split_sentence sentence
    sentence.split(/[ \-?\t.,;\n\]\[\|\)\(\"\'\\\/:!<>]/)
  end

end
