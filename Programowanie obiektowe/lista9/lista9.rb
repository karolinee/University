class Funkcja
  def initialize(blok)
    @blok = blok
  end
  def value(x)
    @blok.call(x)
  end
  def zerowe(a,b,e)
    z = []
    a2 = a + e
    while a2 < b
      if @blok.call(a)*@blok.call(a2) < 0
        z << a2.round(2)
        a = a2
      end
      a2 += e
    end
    if z.empty?
      return nil
    end
    return z
  end
  def pole(a,b)
    suma = 0
    e = 0.001
    while(a < b)
      suma+= (@blok.call(a) * e)
      a += e
    end
    return suma.round(2)
  end
  def poch(x)
    fa = @blok.call(x)
    x += 0.000001
    fb = @blok.call(x)
    return (fb - fa)/ 0.000001
  end
  def plot(a,b)
    f = File.new("data.dat","w")
    while(a < b)
      f.puts(a.to_s + " " + @blok.call(a).to_s)
      a+=0.001
    end

    f.close
  end
end


f = Funkcja.new(lambda { |x| x*x*Math.sin(x) })
puts f.value(1)

puts f.poch(2)
puts f.zerowe(2,5,0.0001)
puts f.pole(0,2)

f.plot(-10,10)
