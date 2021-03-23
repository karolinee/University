public class Pomnoz extends Wyrazenie {
    public Pomnoz(Wyrazenie lewe, Wyrazenie prawe)
    {
        this.lewe = lewe;
        this.prawe = prawe;
    }
    public int oblicz()
    {
        return this.lewe.oblicz() * this.prawe.oblicz();
    }

    @Override
    public String toString() {
        return "( " + this.lewe.toString() + " * " + this.prawe.toString() + " )";
    }

    public Wyrazenie pochodna()
    {
        return new Dodaj(new Pomnoz(this.lewe.pochodna(),this.prawe),new Pomnoz(this.lewe,this.prawe.pochodna()));
    }
}
