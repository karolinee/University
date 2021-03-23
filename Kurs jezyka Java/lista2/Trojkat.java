public class Trojkat {
    private Punkt a;
    private Punkt b;
    private Punkt c;

    public Trojkat(Punkt a, Punkt b, Punkt c) throws Exception {
        if(Punkt.rowne(a, b) || Punkt.rowne(a, c) || Punkt.rowne(b, c)) throw new Exception("błędne punkty");
        if(Punkt.wspoliniowe(a, b, c)) throw new Exception("punkty wspólniniowe");

        this.a = a;
        this.b = b;
        this.c = c;
    }

    public void przesun(Wektor v) {
        this.a.Przesun(v);
        this.b.Przesun(v);
        this.c.Przesun(v);
    }

    public void obroc(Punkt a, double kat) {
        this.a.obroc(a, kat);
        this.b.obroc(a, kat);
        this.c.obroc(a, kat);
    }

    public void odbij(Prosta p) throws Exception {
        this.a.odbij(p);
        this.b.odbij(p);
        this.c.odbij(p);
    }

    public String toString() {
        return "Trójkąt: " + this.a + " - " + this.b + " - " + this.c;
    }
}
