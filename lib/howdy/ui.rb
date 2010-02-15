require 'iconv'

module Howdy
  # Layer for user interface. In the simplest case it's just standard output.
  class UI

    class << self

      # Displays message on defined output (stdout by default)
      def display(message)
        puts convert(message)
      end

      # Displays message on defined output (stderr by default)
      def error(message)
        $stderr.puts convert(message)
      end
      
      # prints list of available dictionaries 
      def list_dictionaries
        Dictionary.available.each do |dict|
          display "  #{dict.dict_label} - #{dict.dict_description}"
        end
      end

      protected
      # Converts message from UTF-8 to system encoding
      # TODO: 
      #   don't assume UTF-8 as default encoding
      #   convert only if necessary
      def convert(message)
        Iconv.iconv(ENV.user_encoding, 'UTF-8', message.to_s).to_s
      end

    end

  end
end
