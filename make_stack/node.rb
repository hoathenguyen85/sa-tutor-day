class Node
  attr_accessor :data, :next_node

  def initialize(data)
    @data = data
  end

  def print_node
    print @data
    unless next_node.nil?
      print "=> "
      print "#{@next_node.print_node}" 
    end
  end

  def to_s
    @data
  end
end