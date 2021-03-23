class Fixnum
  def czynniki
    dzielniki = []
    for i in 1..self
      if self % i == 0
        dzielniki << i
      end
    end
    return dzielniki
  end

  def ack(y)
    if self == 0
      return y + 1
    elsif y == 0
      return (self-1).ack(1)
    else
      return (self-1).ack(self.ack(y-1))
    end
  end

  def doskonala
    sum = 0
    self.czynniki.each { |i| sum+= i}
    return sum == 2*self
  end

  def slownie
    cyfry = ["zero","jeden","dwa","trzy","cztery","pięć","sześć","siedem","osiem","dziewięć"]
    napis = ""
    self.digits.each { |i| napis = cyfry[i] + " " + napis }
    return napis
  end
end

puts 6.czynniki
puts "\n"
puts 13.czynniki
puts "\n\n"


puts 2.ack(1)
puts 0.ack(4)
puts 1.ack(0)
puts "\n\n"

puts 6.doskonala
puts 13.doskonala
puts "\n\n"

puts 123.slownie
puts 0.slownie
