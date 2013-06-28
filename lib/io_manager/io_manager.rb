# encoding: utf-8

require_relative 'file_manager'

  module InputType
    :file
    :database
    :soa
  end

  class IOManager

    def initialize input_type, output_type
      @input_type, @output_type = input_type, output_type
      select_input_instance input_type
    end

    def read_urls input_source
      @input_manager_instance.read_input input_source
    end

    private

    def select_input_instance input_type
      case input_type
      when :file
        @input_manager_instance = IOManager::FileManager.new
      end
    end

  end
