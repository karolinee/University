class Node
  @next = nil
  @prev = nil
  def initialize(x)
    @value = x
  end
  def set_next(x)
    @next = x
  end
  def set_prev(x)
    @prev = x
  end
  def next?
    return if(@next)
  end
  def get_value
    return @value
  end
  def get_next
    return @next
  end
  def get_prev
    return @prev
  end
end

class DoubleLinkedList
  def initialize(value)
    x = Node.new(value)
    @head = @tail = x
    @length = 1
  end
  def get_head
    return @head.get_value
  end
  def get_tail
    return @tail.get_value
  end
  def wypisz
    x = @head
    while x
      puts x.get_value
      x = x.get_next
    end
  end
  def add(value)
    x = Node.new(value)
    @length +=1
    if value < @head.get_value
      @head.set_prev(x)
      x.set_next(@head)
      @head = x
    elsif value > @tail.get_value
      @tail.set_next(x)
      x.set_prev(@tail)
      @tail = x
    else
      temp = @head
      while(value > temp.get_next.get_value)
        temp = temp.get_next
      end
      temp.get_next.set_prev(x)
      x.set_next(temp.get_next)
      x.set_prev(temp)
      temp.set_next(x)
    end
  end
  def get(j)
    temp = @head
    for i in 0...j
      temp = temp.get_next
    end
    return temp.get_value
  end
  def length
    return @length
  end
end

class Wyszukiwanie
  def wyszukiwanie1(kolekcja,v)
    l = 0
    r = kolekcja.length - 1
    while l < r
      s = (l+r)/2
      if v == kolekcja.get(s)
        return true
      elsif v <  kolekcja.get(s)
        r = s - 1
      else
        l = s + 1
      end
    end
      return false
  end
  def wyszukiwanie2(kolekcja,v)
    l = 0
    r = kolekcja.length - 1
    vl = kolekcja.get(l)
    vr = kolekcja.get(r)
    while v>= vl and v <= vr
      s = l + (((v - vl) * (r - l)) / (vr - vl))
      if v == kolekcja.get(s)
        return true
      elsif v <  kolekcja.get(s)
        r = s - 1
        vr = kolekcja.get(r)
      else
        l = s + 1
        vl = kolekcja.get(l)
      end
    end
    return false
  end
end

list = DoubleLinkedList.new(5)
list.add(3)
list.add(7)
list.add(6)
list.add(4)
list.wypisz

wysz = Wyszukiwanie.new
puts wysz.wyszukiwanie2(list,9)
puts wysz.wyszukiwanie2(list,3)
puts wysz.wyszukiwanie2(list,7)

