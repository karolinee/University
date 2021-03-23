package struktury;

public class Para{
    public final String klucz;
    private double wartosc;


    public Para(String klucz, double wartosc) throws Exception {
        if(klucz.isEmpty() || klucz == null || !klucz.matches("[a-z]+")) throw new Exception("błędny klucz");
        this.klucz = klucz;
        this.wartosc = wartosc;
    }

    public double getWartosc() {
        return wartosc;
    }

    public void setWartosc(double wartosc) {
        this.wartosc = wartosc;
    }

    public String toString(){
        return String.format("%s: %f", klucz, wartosc);
    }

    public boolean equals(Object o) {
        if(o == this) return true;
        if(o == null || !(o instanceof Para)) return false;
        Para p = (Para) o;
        return p.klucz.equals(this.klucz);
    }
}