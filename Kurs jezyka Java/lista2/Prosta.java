public final class Prosta {
    public final double A;
    public final double B;
    public final double C;

    public Prosta(double A, double B, double C) {
        this.A = A;
        this.B = B;
        this.C = C;
    }

    public static Prosta przesun(Prosta p,Wektor v) {
        return new Prosta(p.A, p.B, p.C - p.A*v.dx - p.B*v.dy);
    }

    public static boolean rownolegle(Prosta p, Prosta q) {
        return p.A*q.B == q.A*p.B;
    }

    public static boolean prostopadle(Prosta p, Prosta q) {
        return p.A*q.A == -p.B*q.B;
    }

    public static Punkt przeciecie(Prosta p, Prosta q) throws Exception {
        double w = p.A * q.B - q.A * p.B;
        double wx = -p.C*q.B + q.C*p.B;
        double wy = -p.A*q.C + q.A*p.C; 
        return new Punkt(wx/w,wy/w);
    }

    public String toString() {
        return "Prosta : " + A + "x + " + B + "y + " + C + " = 0";
    }
}

