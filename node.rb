# this is a node.
class Node
  attr_reader :value
  attr_accessor :next_node # see below

  # def next_node
  #   @next_node
  # end

  # def next_node=(next_node)
  #   @next_node = next_node
  # end

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end
