require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucketnum = key.hash % @store.length
    @store[bucketnum].include?(key)
  end

  def set(key, val)
    resize! if @count == @store.length
    bucketnum = key.hash % @store.length
    unless @store[bucketnum].include?(key)
      @store[bucketnum].append(key,val)
      @count += 1
    else
      @store[bucketnum].update(key,val)
    end
  end

  def get(key)
    bucketnum = key.hash % @store.length
    @store[bucketnum].get(key) if @store[bucketnum].include?(key)
  end

  def delete(key)
    bucketnum = key.hash % @store.length
    if @store[bucketnum].include?(key)
      @store[bucketnum].remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |linklist|
      linklist.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_hashmap = Array.new(@store.length * 2){LinkedList.new}
    @store.each do |linkedlist|
      linkedlist.each do |node|
        bucketnum = node.key.hash % new_hashmap.length
        new_hashmap[bucketnum].append(node.key, node.val)
      end
    end
    @store = new_hashmap

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
