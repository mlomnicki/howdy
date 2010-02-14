module Howdy

  class Pair

    attr_accessor :left, :right

    CENTER = 85

    def initialize(left = nil, right = nil)
      @left = left
      @right = right
    end

    def to_s
      "#{@left.center(CENTER)} => #{@right.center(CENTER)}"
    end

    alias :inspect :to_s

  end

end
