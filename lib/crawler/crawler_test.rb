#encoding: utf-8

require '../io_manager/io_manager'
require 'crawler'

io = IOManager.new :file, :file
urls = io.read_urls "../io_manager/url_test.txt"
puts urls
