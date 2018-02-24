class MaxIntSet
  def initialize(max)
    @set = Array.new(max, false)
  end

  def insert(num)
    if num >= @set.length || num < 0
      raise "Out of bounds"
    else
      @set[num] = true if @set[num] == false
    end
  end

  def remove(num)
    @set[num] = false
  end

  def include?(num)
    @set[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucketnum = num % @store.length
    @store[bucketnum] << num

  end

  def remove(num)
    bucketnum = num % num_buckets
    @store[bucketnum].delete(num)
  end

  def include?(num)
    bucketnum = num % @store.length
    return true if @store[bucketnum].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == @store.length
    bucketnum = num % @store.length
    unless @store[bucketnum].include?(num)
      @store[bucketnum] << num
      @count += 1
    end
  end

  def remove(num)
    bucketnum = num % @store.length
    @count -= 1 unless @store[bucketnum].delete(num).nil?
  end

  def include?(num)
    bucketnum = num % @store.length
    return true if @store[bucketnum].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    if @store.count == @store.length
      new_store = Array.new(@store.count * 2) { Array.new }
      @store.each do |bucket|
        bucket.each do |el|
          bucketnum = el % new_store.length
          new_store[bucketnum] << el
        end
      end
    end
    @store = new_store
  end
end
