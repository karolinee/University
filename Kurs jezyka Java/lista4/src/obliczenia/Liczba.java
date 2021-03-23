package obliczenia;

import obliczenia.op1arg.Operator1Arg;

public class Liczba extends Wyrazenie {
    private int liczba;

    public Liczba(int liczba){
        this.liczba = liczba;
    }
    @Override
    public int oblicz() {
        return liczba;
    }

    @Override
    public String toString() {
        return String.valueOf(liczba);
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == this) return true;
        if(obj == null || (this.getClass() != obj.getClass())) return false;
        Liczba l = (Liczba) obj;
        return this.liczba == l.liczba;
    }
}
