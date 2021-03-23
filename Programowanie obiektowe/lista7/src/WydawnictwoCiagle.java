public class WydawnictwoCiagle extends Ksiazka {
    public WydawnictwoCiagle(String autor, String tytul, int wydanie){
        super(autor,tytul,wydanie);
    }

    public String toString() {
        return "Wydawnictwo ciągłe pod tytułem: " + this.tytul + " autorstwa " + this.autor;
    }
}
