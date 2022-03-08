require './node'

# A linked list!
class LinkedList
  def initialize(initial_values = [])
    @head = nil

    initial_values.each do |value|
      append(value)
    end
  end

  # adds new node containing value to end of list
  def append(value)
    if @head
      current = @head
      loop do
        if current.next_node.nil?
          current.next_node = Node.new(value)
          return
        else
          current = current.next_node
        end
      end
    else
      @head = Node.new(value)
    end
  end

  # adds new node containing value to start of the list
  def prepend(value)
    if @head
      tmp = @head
      @head = Node.new(value)
      @head.next_node = tmp
    else
      @head = Node.new(value)
    end
  end

  # returns total number of nodes in the list
  # def size
  #   return 0 if @head.nil?

  #   i = 0
  #   current = @head
  #   loop do
  #     i += 1
  #     if current.next_node.nil?
  #       break
  #     end
  #     current = current.next_node
  #   end
  #   i
  # end

  # equivalent of size but shorter
  def size
    i = 0
    each_node do
      i += 1
    end
    i
  end

  # returns first node in the list
  attr_reader :head

  # returns last node in the list
  def tail
    return unless @head

    @tail = @head
    loop do
      return @tail if @tail.next_node.nil?

      @tail = @tail.next_node
    end
  end

  # returns the node at the given index
  def at(index)
    current = @head
    i = 0
    while i < index
      return nil if current.next_node.nil?

      i += 1
      current = current.next_node
    end
    current
  end

  # removes the last element from the list
  def pop
    return if @head.nil?

    if @head.next_node.nil?
      @head = nil
    else
      previous_node = @head
      current = @head.next_node
      loop do
        if current.next_node.nil?
          previous_node.next_node = nil
          return
        else
          current = current.next_node
          previous_node = previous_node.next_node
        end
      end
    end
  end

  # returns true if the passed in value is in the list, if not false
  def contains?(value)
    return false unless @head

    current = @head
    loop do
      return true if current.value == value

      current = current.next_node
      return false if current.nil?
    end
  end

  # returns index of the node containing value, or nil if not found
  def find(value)
    return unless @head

    i = 0
    current = @head
    loop do
      return i if current.value == value

      current = current.next_node
      i += 1
      return if current.nil?
    end
  end

  # Yields to the block with each value in the list
  def each
    return unless @head

    current = @head
    loop do
      yield(current.value)
      return if current.next_node.nil?

      current = current.next_node
    end
  end

  # yields the node itself with each
  def each_node
    return unless @head

    current = @head
    loop do
      yield(current)
      return if current.next_node.nil?

      current = current.next_node
    end
  end

  def each_with_index
    i = 0
    each do |value|
      yield(value, i)
      i += 1
    end
  end

  def select
    arr = LinkedList.new
    each do |value|
      arr << value if yield(value)
    end
    arr
  end

  def all?
    each do |value|
      return false unless yield(value)
    end
    true
  end

  def any?
    each do |value|
      return true if yield(value)
    end
    false
  end

  def none?
    !any?
  end

  def map
    arr = LinkedList.new
    each do |value|
      arr << yield(value)
    end
    arr
  end

  def inject(initial_value)
    result = initial_value
    each do |value|
      result = yield(value, result)
    end
    result
  end

  # represent LinkedList object as strings, so able to print and preview them in console.
  # format of output ( value ) -> ( value ) -> ( value ) -> nil
  def to_s
    s = ''
    each do |current|
      s += "( #{current} ) -> "
    end
    "#{s}nil"
  end

  def <<(value)
    append(value)
  end
end
