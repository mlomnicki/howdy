$: << File.join(File.dirname(__FILE__), 'howdy')

require 'core_ext/ruby/string/underscore'
require 'base'
require 'ui'
Dir[File.join(File.dirname(__FILE__), 'howdy', 'dictionaries', '*.rb')].each { |dict| require dict }

