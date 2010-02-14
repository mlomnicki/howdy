module Howdy

  module Dictionary

    class LingPl < Base

      url 'http://www2.ling.pl/lingfeed-ps.php?word=#{user_query}&sType=0&chooseLang=1'
      label 'ling.pl'
      description 'Polish-English dictionary'

      def parse
        document.css('div.dictdef')[0..2].each do |definiton|
          result << "\n#{definiton.content}\n\n"
        end
      end

    end
  end

end


