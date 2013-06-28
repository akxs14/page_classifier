# encoding: utf-8

require 'net/http'

class Crawler

  def initialize page_batch_size = 100
    @page_batch_size, @urls = page_batch_size, []
  end

  def crawl urls
    crawled_page_content = {}
    urls.each {|url| crawled_page_content[url] = crawl_page(url) }
    crawled_page_content
  end

  private

  def crawl_page url
    Net::HTTP.get(URI(url))
  end

end
