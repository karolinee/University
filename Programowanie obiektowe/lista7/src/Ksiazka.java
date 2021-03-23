import javax.swing.*;

public class Ksiazka extends JFrame {
    public String autor;
    public String tytul;
    public int wydanie;

    public Ksiazka(String autor, String tytul, int wydanie) {
        this.tytul = tytul;
        this.autor = autor;
        this.wydanie = wydanie;
    }

    public Ksiazka() {

    }

    public String toString() {
        return "Książka pod tytułem: " + this.tytul + " autorstwa " + this.autor;
    }
}
