public class Podziel extends Wyrazenie {
    public Podziel(Wyrazenie lewe, Wyrazenie prawe)
    {
        this.lewe = lewe;
        this.prawe = prawe;
    }

    public int oblicz()
    {
        return (this.lewe.oblicz())/(this.prawe.oblicz());
    }
    public String toString() {
        return "( " + this.lewe.toString() + " / " + this.prawe.toString() + " )";
    }

    public Wyrazenie pochodna()
    {
        return new Podziel(new Odejmij(new Pomnoz(this.lewe.pochodna(),this.prawe),new Pomnoz(this.lewe,this.prawe.pochodna())),new Pomnoz(this.lewe,this.lewe));
    }
}
