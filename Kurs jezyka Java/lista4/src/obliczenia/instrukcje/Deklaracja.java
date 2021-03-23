package obliczenia.instrukcje;

import obliczenia.Zmienna;

public class Deklaracja extends Instrukcja{
    private String nazwa;
    public Deklaracja(String nazwa){
        if(nazwa.isBlank() || nazwa.isEmpty()) throw new IllegalArgumentException("nazwa nie może byc pustym listerałem");
        this.nazwa = nazwa;
    }

    public String getNazwa(){
        return this.nazwa;
    }

    @Override
    public void wykonaj() {
        if(Zmienna.istniejeZmienna(nazwa)) throw new IllegalArgumentException("zmienna o tej nazwie już istnieje");
        Zmienna.dodajZmienna(nazwa, 0);
    }

    @Override
    public String toString() {
        return "var " + nazwa + ";";
    }
}
