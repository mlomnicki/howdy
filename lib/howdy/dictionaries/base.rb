require 'open-uri'
require 'uri'
require 'nokogiri'

module Howdy

  module Dictionary
      
    def self.current
      @@dictionary ||= default_dictionary
    end

    def self.set(dictionary)
      @@dictionary = dictionary
    end

    def self.default_dictionary
      DictPl
    end

    class Base

      attr_reader :user_query

      def initialize(user_query)
        @user_query = user_query
      end

      def self.url(dictionary_url)
        @url = dictionary_url
      end

      def self.dict_url
        @url
      end

      def self.encoding(enc)
        @encoding = enc.to_s
      end

      def self.doc_encoding
        @encoding ||= 'UTF-8'
      end

      def parse
        raise Howdy::HowdyError, "Implement parse in your Dictionary::Base subclass"
      end

      def document
        @document ||= Nokogiri::HTML(open(URI.escape(interpolated_url)), nil, self.class.doc_encoding)
      end

      def result
        @result ||= []
      end

      def print
        if result.empty?
          puts "Nothing found"
        else
          result.each do |item|
            puts item.to_s
          end
        end
      end

      protected
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
