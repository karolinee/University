public class Stala extends Wyrazenie{
    int liczba;

    public Stala(int liczba)
    {
        this.liczba = liczba;
        this.lewe = null;
        this.prawe = null;
    }

    public int oblicz()
    {
        return this.liczba;
    }
    public String toString() {
        return Integer.toString(liczba);
    }

    public Wyrazenie pochodna()
    {
        return new Stala(0);
    }
}
