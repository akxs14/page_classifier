#encoding: utf-8

require '../io_manager/io_manager'
require '../crawler/crawler'
require 'html_parser'

io = IOManager.new :file, :file
urls = io.read_urls "../../spec/url_test.txt"

crawler = Crawler.new
crawled_urls = crawler.crawl(urls)

parser = HtmlParser.new
puts parser.parse_pages(crawled_urls)

