class Jawna
  def initialize(napis)
    @napis = napis
  end
  def zaszyfruj(klucz)
    kod = ""
    @napis.each_char { |i| kod << klucz[i]}
    return Zaszyfrowane.new(kod)
  end
  def to_s
    "Napis jawny: " + @napis
  end
end

class Zaszyfrowane
  def initialize(napis)
    @napis = napis
  end
  def odszyfruj(klucz)
    kod = ""
    @napis.each_char { |i| kod << klucz.key(i) }
    return Jawna.new(kod)
  end
  def to_s
    "Napis zaszyfrowany: " + @napis
  end
end

j = Jawna.new('ruby')
puts j
klucz = {'a'=>'b', 'b'=>'r', 'r'=>'y', 'y'=> 'u', 'u'=>'a'}

z = j.zaszyfruj(klucz)
puts z

puts z.odszyfruj(klucz)