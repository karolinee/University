public class Punkt {
    private double x;
    private double y;


    public Punkt(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public void Przesun(Wektor v) {
        this.x += v.dx;
        this.y += v.dy;
    }

    public void obroc(Punkt a, double kat) {
        double katRadians = Math.toRadians(kat);
        double x = (this.x - a.x)*Math.cos(katRadians) - (this.y - a.y)*Math.sin(katRadians) + a.x;
        double y = (this.x - a.x)*Math.sin(katRadians) + (this.y - a.y)*Math.cos(katRadians) + a.y;

        this.x = x;
        this.y = y;
    }

    public void odbij(Prosta p) throws Exception {
        double A = -p.B;
        double B = p.A;
        double C = -B*this.y - A*this.x;
        
        Prosta prostopadla = new Prosta(A, B, C);        
        Punkt srodek = Prosta.przeciecie(p, prostopadla);

        this.x = 2*srodek.x - this.x;
        this.y = 2*srodek.y - this.y;   
    }

    public static boolean rowne(Punkt a, Punkt b) {
        return (a.x == b.x && a.y == b.y);
    }

    public static boolean wspoliniowe(Punkt a, Punkt b, Punkt c) {
        return ((a.y - b.y)*(a.x - c.x) == (a.y - c.y)*(a.x - b.x));
    }

    public String toString() {
        return "x = " + this.x + " y = " + this.y;
    }
}