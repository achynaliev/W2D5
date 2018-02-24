class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    # head = Node.new(:head)
    # tail = Node.new(:tail)
    # head.next = tail
    # tail.prev = head
    #
    @list = []
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @list[0]
  end

  def last
    @list[-1]
  end

  def empty?
    @list.empty?
  end

  def get(key)
    @list.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    @list.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    # head --------        tail
    if empty?
      @list << new_node
    else
      new_node.prev = @list[-1]
      @list[-1].next = new_node
      @list << new_node
    end
  end

  def update(key, val)
    @list.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    @list.each do |node|
       if node.key == key
         node.prev.next = node.next  unless node.prev.nil?
         node.next.prev = node.prev unless node.next.nil?
         @list.delete(node)
       end
    end
  end

  def each(&prc)

    @list.each do |node|
      prc.call(node)
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
