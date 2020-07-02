class Node
  attr_reader :value
  attr_accessor :next_node
  
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  def initialize()
    @head = nil
    @tail = nil
  end

  def append(value)
    if !head
      @head = Node.new(value)
      @tail = @head
    else
      current = head
      while current.next_node != nil
        current = current.next_node
      end

      current.next_node = Node.new(value)
      @tail = current.next_node
    end
  end

  def prepend(value)
    if !head
      @head = Node.new(value)
      @tail = @head
    else
      new_node = Node.new(value, @head)
      @head = new_node
    end
  end

  def size
    return 0 if !head

    current = head
    i = 1

    while current.next_node != nil
      i += 1
      current = current.next_node
    end

    i
  end

  def at(index)
    return nil if !head

    current = head
    i = 0

    while i != index
      break if current == nil

      current = current.next_node
      i += 1
    end

    current
  end

  def pop
    if head
      if head.next_node == nil
        @head = nil
        @tail = nil
      else
        current = head
        previous = nil
        while current.next_node != nil
          previous = current
          current = current.next_node
        end

        previous.next_node = nil
        @tail = previous
      end
    end
  end

  def contains?(value)
    return false if !head

    return true if head.value == value

    current = head

    while current.next_node != nil
      current = current.next_node

      return true if current.value == value
    end

    false
  end

  def find(value)
    return nil if !head

    current = head
    i = 0

    while current != nil
      return i if current.value == value

      current = current.next_node
      i += 1
    end

    nil
  end

  def to_s
    return "" if !head

    str = ""
    current = head

    while current != nil
      str += "( #{ current.value } ) -> "
      current = current.next_node
    end

    str += "nil"

    str
  end

  def insert_at(value, index)
    if !head
      if index == 0
        @head = Node.new(value)
        @tail = @head
      else
        return "cannot insert"
      end
    else
      current = head

      if index == 0
        @head = Node.new(value, current)
        return
      end

      previous = nil
      i = 0

      while i != index
        return "cannot insert" if current == nil

        previous = current
        current = current.next_node
        i += 1
      end

      previous.next_node = Node.new(value, current)

      if previous.value == @tail.value
        @tail = previous.next_node
      end
    end
  end

  def remove_at(index)
    if !head
      return false
    else
      current = head

      if current.next_node == nil
        @head = nil
        @tail = nil
        return true
      else
        if index == 0
          @head = current.next_node
          return true
        end
      end

      previous = nil
      i = 0

      while i != index
        return false if current == nil

        previous = current
        current = current.next_node
        i += 1
      end

      previous.next_node = current.next_node

      @tail = previous if @tail.value == current.value
    end
  end

  def head
    @head
  end

  def tail
    @tail
  end
end

a = LinkedList.new

a.append("5")
a.append("7")
a.append("9")

a.prepend("3")

a.pop

a.insert_at("1", 0)
a.insert_at("6", 3)
a.insert_at("8", 5)
a.insert_at("10", 8)

a.remove_at(0)
a.remove_at(2)
a.remove_at(3)
a.remove_at(10)

p a.head
p a.tail

p a.size

p a.at(1)

p a.contains? "7"

p a.find("7")

p a.to_s

p a