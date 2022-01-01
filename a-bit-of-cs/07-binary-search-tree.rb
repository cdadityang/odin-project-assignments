class Node
  attr_reader :value
  attr_accessor :left, :right
  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

class Tree
  def initialize(array)
    @root = build_tree(array)

    @arr = []
  end

  def build_tree(array)
    return nil if array.length < 1

    root_node = Node.new(array[0])

    (1...array.length).each do |n|
      insert(array[n], root_node)
    end

    root_node
  end

  def insert(element, current_node = @root)
    return nil if element == current_node.value

    if element < current_node.value
      if current_node.left == nil
        current_node.left = Node.new(element)
        return
      else
        insert(element, current_node.left)
      end
    else
      if current_node.right == nil
        current_node.right = Node.new(element)
        return
      else
        insert(element, current_node.right)
      end
    end
  end

  def find(element, current_node = @root)
    return current_node if current_node.value == element

    if element < current_node.value
      if current_node.left != nil
        find(element, current_node.left)
      end
    else
      if current_node.right != nil
        find(element, current_node.right)
      end
    end
  end

  def in_order(current_node = @root, &block)
    return nil if current_node == nil

    in_order(current_node.left, &block) if current_node.left
    block_given? ? yield(current_node) : @arr.push(current_node.value)
    in_order(current_node.right, &block) if current_node.right

    @arr unless block_given?
  end

  def root_h
    @root
  end
end

a = Tree.new([5, 3, 1, 4, 7, 6, 8])

a.insert(9)

p a.find(7)

p a.in_order

p a.root_h