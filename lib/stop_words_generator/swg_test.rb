require_relative 'stop_words_generator'

swg = StopWordsGenerator.new
swg.create_stop_word_dict
puts swg.load_stop_words_dict
