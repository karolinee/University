package obliczenia.instrukcje;

import obliczenia.Zmienna;

import java.util.Scanner;

public class Czytaj extends Instrukcja{
    private String nazwa;
    public Czytaj(String nazwa){
        this.nazwa = nazwa;
    }
    @Override
    public void wykonaj() {
        Scanner in = new Scanner(System.in);
        int i = in.nextInt();
        if(!Zmienna.istniejeZmienna(nazwa)) throw new IllegalArgumentException("brak zmiennej o takiej nazwie");
        Zmienna.dodajZmienna(nazwa, i);
    }

    @Override
    public String toString() {
        return "read " + nazwa + ";";
    }
}
