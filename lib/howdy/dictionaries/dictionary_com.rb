module Howdy

  module Dictionary

    class DictionaryCom < Base

      url 'http://dictionary.reference.com/browse/#{user_query}'

      def parse
        document.css('div.KonaBody div.results_content table.luna-Ent tr').each do |row|
          result << row.search('td').children.collect { |e| e.content }.join
        end
      end

    end
  end

end


