# encoding: utf-8
class StopWordsGenerator

  def initialize input_folder = "../../spec/stop_words_gen_input"
    @input_folder, @word_count = input_folder, 0
    @word_dictionary, @word_frequencies = {}, {}
    @stop_word_frequency_threshold = 0.0001
  end

  def create_stop_word_dict
    files = list_input_files
    files.each do |file|
      puts "reading file #{file}"
      read_input_file file
    end

    sort_stop_words
    calculate_word_frequencies
    discard_non_stop_words
    save_stop_words_in_file
  end

  def save_stop_words_in_file
    f = File.open("stop_words.txt", "w")
    @word_frequencies.each do |k,v|
      puts "#{k}, #{v[:frequency]}\n"
      f.write("#{k}, #{v[:frequency]}\n")
    end
  end

  private

  def list_input_files
    files = []
    Dir.foreach(@input_folder) do |item|
      next if (/[\.]/ =~ item) == 0
      files << @input_folder + "/" + item
    end
    files
  end

  def read_input_file input_file
    File.readlines(input_file).each do |line|
      words = discard_useless_strings(split_line(line))
      add_words words
    end
  end

  def add_words words
    return if words == []
    @word_count += 1

    words.map(&:downcase).each do |word|
      if !@word_dictionary[word]
        @word_dictionary[word] = 1
      else
        cur_freq = @word_dictionary[word]
        @word_dictionary[word] = (cur_freq + 1)
      end
    end
  end

  def sort_stop_words
    @word_dictionary = Hash[@word_dictionary.sort_by{|k,v| v}.reverse]
  end

  def calculate_word_frequencies
    wc = @word_count
    @word_dictionary.each do |k,v|
      @word_frequencies[k] = { observations: v, frequency: v.to_f / wc }
    end
  end

  def discard_non_stop_words
    @word_frequencies.each do |k,v|
      if v[:frequency] < @stop_word_frequency_threshold
        @word_dictionary.delete(k)
        @word_frequencies.delete(k)
      end
    end
  end

  #candidate to go to a separate module
  def discard_useless_strings tokens_array
    tokens_array.delete_if do |item|
      item.length < 1 or
      (item.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true )
    end
  end

  def split_line line
    line.split(/[ _=\*\-?\t.,;\r\n\]\[\|\)\(\"\'\\\/:$!<>]/)
  end

end