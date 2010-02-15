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
        Dictionary.available.each do |dict|
          display "  #{dict.dict_label} - #{dict.dict_description}"
        end
      end

    end

  end
end
