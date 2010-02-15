# Chunk from ruby-nuggets library is needed to determine system encoding.
# http://github.com/blackwinter/ruby-nuggets/

require File.join(File.dirname(__FILE__), 'nuggets', 'user_encoding_mixin')

ENV.extend(Nuggets::Env::UserEncodingMixin)
