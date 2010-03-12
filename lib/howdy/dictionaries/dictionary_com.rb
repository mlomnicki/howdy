module Howdy

  module Dictionary

    class DictionaryCom < Base

      url 'http://dictionary.reference.com/browse/#{user_query}'
      label 'dictionary.com'
      description 'English dictionary'

      def parse
        document.css('div.KonaBody div.results_content div.luna-Ent div.body div.luna-Ent').each do |row|
          index = row.search('span.dnindex').children.collect { |e| e.content }.join
          data  = row.search('div.dndata').children.collect { |e| e.content }.join
          result << index + data
        end
      end

    end
  end

end


