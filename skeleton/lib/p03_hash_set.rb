require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @store.length == @count
    bucketnum = key.hash % @store.length
    unless @store[bucketnum].include?(key)
      @store[bucketnum] << key
      @count += 1
    end
  end

  def include?(key)
    bucketnum = key.hash % @store.length
    return true if @store[bucketnum].include?(key)
    false
  end

  def remove(key)
    bucketnum = key.hash % @store.length
    if @store[bucketnum].include?(key)
      @store[bucketnum].delete(key)
      @count -= 1
    end 

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
