public class Czasopismo extends Ksiazka {
    public Czasopismo(String autor, String tytul, int wydanie){
        super(autor,tytul,wydanie);
    }

    public String toString() {
        return "Czasopismo pod tytułem: " + this.tytul + " autorstwa " + this.autor;
    }
}
