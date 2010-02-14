module Howdy

  module Dictionary

    class DictPl < Base

      url 'http://www.dict.pl/dict?word=#{user_query}'
      name 'dict.pl'
      description 'Polish-English dictionary'

      def parse
        document.css('table.resTable tr.resRow').each do |row|
          left, right = row.search('td.resWordCol a')
          if left.content == user_query
            result << right.content
          elsif right.content == user_query
            result << left.content
          end
        end
      end

    end
  end

end


