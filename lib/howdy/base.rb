require 'open-uri'
require 'uri'
require 'nokogiri'

module Howdy # :nodoc
  
  # Standard Howdy exception
  class HowdyError < Exception; end

  # Howdy::Dictionary exposes accessors of dictionaries collection.
  module Dictionary

    # Returns current dictionary class
    def self.current
      @@dictionary ||= default
    end

    # Set current dictionary. Pass a class as an argument
    #   Howdy::Dictionary.set(DictionaryCom)
    def self.set(dictionary)
      @@dictionary = dictionary
    end

    # Returns default dictionary
    def self.default
      DictionaryCom
    end

    # Returns array of available dictionaries
    def self.available
      @@available_dictionaries ||= []
    end

    # Find dictionary class by label
    def self.find_by_label(label)
      available.detect { |dict| dict.dict_label == label.to_s }
    end

    # Base class for all dictionaries. Inherit from it if you want to implement
    # your own dictionary.
    #   Example:
    #
    #     class AwesomeDictionary < Howdy::Dictionary::Base
    #
    #       url 'http://awesome.example.com?word=#{user_query}'
    #       label 'example.com'
    #       description 'Most awesome dictionary you've ever seen'
    #
    #       def parse
    #         document.css('table.results tr td.word') do |cell|
    #           result << cell.content
    #         end
    #       end
    #     end
    class Base

      attr_reader :user_query

      def self.inherited(base) # :nodoc
        Howdy::Dictionary.available << base
      end

      def initialize(user_query) # :nodoc
        @user_query = user_query
      end

      # Sets URL to query the web dictionary.
      # You must pass protocol as well:
      #   http://dictionary.com is correct
      #   dictionary.com is incorrect
      #
      # URL is interpolated:
      #   'http://dictionary.com/browse/#{user_query}'
      #
      # <tt>user_query</tt> is a string given by the user
      #  
      # You may provide own interpolations easily:
      #   Example:
      #   class Dictionary < Howdy::Dictionary::Base
      #     url 'http://awesome.example.com?word=#{user_query}&language=#{lang}'
      #     label 'example.com'
      #     description 'Interpolations example'
      #
      #     def lang
      #       File.read('/etc/howdy/language.conf')
      #     end
      #
      #     def parse
      #        # implement parsing
      #     end
      #
      #   end
      #
      #   In that example #{lang} in url will be replaced with content of
      #   /etc/howdy/language.conf
      #
      # Indicate the url must be given using <b>SINGLE QUOTES</b>.
      def self.url(dictionary_url)
        @url = dictionary_url
      end

      # Returns URL of the dictionary
      def self.dict_url
        @url
      end

      # Sets a label of the dictionary. Label is used when listing available
      # dictionaries
      def self.label(human_name)
        @name = human_name.to_s
      end

      # Sets a description of the dictionary. Description is used when listing
      # available dictionaries.
      def self.description(dictionary_description)
        @description = dictionary_description
      end

      # Returns label of the dictionary.
      def self.dict_label
        @name ||= self.label.underscore
      end

      # Returns description of the dictionary.
      def self.dict_description
        @description ||= ""
      end

      # Sets an encoding of content returned by HTTP response.
      def self.encoding(enc)
        @encoding = enc.to_s
      end

      # Returns an encoding of HTTP response. UTF-8 by default.
      def self.doc_encoding
        @encoding ||= 'UTF-8'
      end

      # Method which transformates raw content received in HTTP response to
      # human-friendly form. Usually you'll use +document+ which exposes
      # the raw content wrapped by Nokogiri parser. Read to nokogiri
      # documentation for details.
      #
      # Each human readable word goes to +result+ array.
      # 
      #   Example:
      #     def parse
      #       document.css('table.content tr td.word').each do |row|
      #         result << row.content
      #       end
      #     end  
      #
      def parse
        raise Howdy::HowdyError, "Implement parse in your Dictionary::Base subclass"
      end

      # Returns content of HTTP response wrapped in Nokogiri::HTML backend.
      def document
        @document ||= Nokogiri::HTML(open(URI.escape(interpolated_url)), nil, self.class.doc_encoding)
      end

      # Array which stores the answers for the user query. Used in +parse+ method.
      #   Example:
      #   result << 'Polyglot - a person who speaks, writes, or reads a number of languages'
      def result
        @result ||= []
      end

      # Prints the contents of +result+ array. You may ovveride it in subclass.
      def print
        if result.empty?
          UI.error "Nothing found"
        else
          result.each do |item|
            UI.display item.to_s
          end
        end
      end

      protected
      # Returns url with interpolated literals. Literals are interpolated using
      # corresponding instance methods.
      #   Example:
      #     url 'http://example.com/word/#{foo}'
      #
      #     def foo
      #       'bar'
      #     end
      #
      # <tt>interpolated_url</tt> will return: 
      #   http://example/com/word/bar
      def interpolated_url
        @interpolated_url ||= self.class.dict_url.gsub(/#\{[^\}]+\}/) do |interpolation|
          method = interpolation[2..-2].to_sym # drop leading '#{' and trailing '}'
          raise Howdy::HowdyError.new("Dictionary has to respond to #{method} in order to use it in query") unless respond_to?(method)
          send(method)
        end
      end

    end

  end

end
