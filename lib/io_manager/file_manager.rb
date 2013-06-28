#encoding: utf-8

  class FileManager

      def read_input input_source
        read_input_file input_source
      end

      def read_input_file file_name
        urls = []
        File.open(file_name).each do |line|
          puts line if correct_url_format? line
        end
      end

      private

      def correct_url_format? url
        /https?:\/\/[\S]+/ =~ url
      end

  end

