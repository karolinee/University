package obliczenia.instrukcje;

public class Wypisz extends Instrukcja{
    private int liczba;
    public Wypisz(int liczba){
        this.liczba = liczba;
    }

    @Override
    public void wykonaj() {
        System.out.println(liczba);
    }

    @Override
    public String toString() {
        return "write " + liczba + ";";
    }
}
