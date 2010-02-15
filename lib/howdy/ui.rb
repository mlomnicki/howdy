module Howdy
  # Layer for user interface. In the simplest case it's just standard output.
  class UI

    class << self

      # Displays message on defined output (stdout by default)
      def display(message)
        puts message
      end

      # Displays message on defined output (stderr by default)
      def error(message)
        $stderr.puts message
      end
      
      # prints list of available dictionaries 
      def list_dictionaries
        Dictionary.available.each_with_index do |dict, idx|
          display " #{idx+1}. #{dict.dict_label} - #{dict.dict_description}"
        end
      end

      # Display message and wait for user input.
      # Returns captured data
      def prompt(message)
        print "#{message}: "
        gets
      end

      def choose_dictionary
        list_dictionaries
        range = Dictionary.range_available
        index = prompt("Choose [#{range}]").to_i
        unless range.include?(index)
          error "No such dictionary. Choose one number of [#{range}]"
          exit 1
        end
        Dictionary.available[index-1]
      end

    end

  end
end
