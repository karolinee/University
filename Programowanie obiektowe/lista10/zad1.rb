class Kolekcja
  def initialize
    @kol = []
  end
  def add(x)
    @kol << x
  end
  def wypisz
    puts @kol
  end
  def get(i)
    return @kol[i]
  end
  def swap(i,j)
    t = @kol[i]
    @kol[i] = @kol[j]
    @kol[j] = t
  end
  def length
    return @kol.length
  end
  def take(n)
    return @kol.take(n)
  end
  def drop(n)
    return @kol.drop(n)
  end
end

class Sortowanie
  def sort1(kolekcja)
    n = kolekcja.length
    for i in 0...n-1
      for j in 0...n-i-1
        if kolekcja.get(j) > kolekcja.get(j+1)
          kolekcja.swap(j,j+1)
        end
      end
    end
  end
  def sort2(kolekcja)
    n = kolekcja.length
    for i in 0...n-1
      min_indx = i
      for j in i+1...n
        if(kolekcja.get(min_indx) > kolekcja.get(j))
          min_indx = j
        end
      end
      kolekcja.swap(i,min_indx)
    end
  end
end

k = Kolekcja.new
for i in 0..10
  k.add(rand(100))
end

k.wypisz
puts ""

sort = Sortowanie.new
sort.sort2(k)
k.wypisz

