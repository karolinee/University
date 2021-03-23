package obliczenia.instrukcje;

import obliczenia.Wyrazenie;
import obliczenia.Zmienna;

public class Przypisanie extends Instrukcja{
    String nazwa;
    Wyrazenie wyr;
    public Przypisanie(String nazwa, Wyrazenie wyr){
        if(wyr == null) throw new IllegalArgumentException("argumenty nie mogą być null");
        if(nazwa.isBlank() || nazwa.isEmpty()) throw new IllegalArgumentException("nazwa nie może byc pustym listerałem");
        this.nazwa = nazwa;
        this.wyr = wyr;
    }

    @Override
    public void wykonaj() {
        if(!Zmienna.istniejeZmienna(nazwa)) throw new IllegalArgumentException("brak zmiennej o takiej nazwie");
        Zmienna.dodajZmienna(nazwa, wyr.oblicz());
    }

    @Override
    public String toString() {
        return nazwa + " = " + wyr.toString() + ";";
    }
}
