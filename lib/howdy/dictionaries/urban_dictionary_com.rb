module Howdy
	module Dictionary
		class UrbanDictionaryCom < Base

			url 'http://www.urbandictionary.com/define.php?term=#{user_query}'
      name 'urbandictionary.com'
      description 'Slang dictionary'

			def parse
				document.css('table#entries tr td.text').each do |cell|
					result << "#{cell.search('div.definition').children.collect { |e| e.content }.join}\n"
					result << "#{cell.search('div.example').children.collect { |e| e.content }.join}\n\n"
				end
			end
		end
	end
end


