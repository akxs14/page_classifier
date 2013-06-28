# encoding: utf-8

class Crawler

  def initialize page_batch_size = 100
    @page_batch_size, @urls = page_batch_size, []
  end

  def crawl urls
    puts urls
  end

end
