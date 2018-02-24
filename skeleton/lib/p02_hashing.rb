require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.to_s.chars.map(&:ord).reduce do |el, el2|
      if el > el2
        el / el2
      else
        el * el2
      end
    end.hash
  end
end

class String
  def hash
    self.to_s.chars.map(&:ord).reduce do |el, el2|
      if el > el2
        el / el2
      else
        el * el2
      end
    end.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_s.chars.map(&:ord).reduce(:+).hash
  end
end
