public class Odejmij extends Wyrazenie{
    public Odejmij(Wyrazenie lewe, Wyrazenie prawe)
    {
        this.lewe = lewe;
        this.prawe = prawe;
    }
    public int oblicz()
    {
        return this.lewe.oblicz() - this.prawe.oblicz();
    }

    public String toString() {
        return "( " + this.lewe.toString() + " - " + this.prawe.toString() + " )";
    }

    public Wyrazenie pochodna()
    {
        return new Odejmij(this.lewe.pochodna(),this.prawe.pochodna());
    }
}
