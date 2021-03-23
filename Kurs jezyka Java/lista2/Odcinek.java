public class Odcinek {
    private Punkt a;
    private Punkt b;

    public Odcinek(Punkt a, Punkt b) throws Exception {
        if(Punkt.rowne(a, b)) throw new Exception("dwa te same punkty");
        this.a = a;
        this.b = b;
    }

    public void przesun(Wektor v) {
        this.a.Przesun(v);
        this.b.Przesun(v);
    }

    public void obroc(Punkt a, double kat) {
        this.a.obroc(a, kat);
        this.b.obroc(a, kat);
    }

    public void odbij(Prosta p) throws Exception {
        this.a.odbij(p);
        this.b.odbij(p);
    }

    public String toString() {
        return "Odcinek: " + this.a + " - " + this.b;
    }
}
