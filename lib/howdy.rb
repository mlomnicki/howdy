$: << File.join(File.dirname(__FILE__),'howdy')

require 'pair'
require 'dictionaries/base'
require 'dictionaries/dict_pl'
require 'dictionaries/ling_pl'

module Howdy

  class HowdyError < Exception; end

end

