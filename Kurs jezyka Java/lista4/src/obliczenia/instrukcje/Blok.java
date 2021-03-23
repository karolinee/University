package obliczenia.instrukcje;

import obliczenia.Wyrazenie;
import obliczenia.Zmienna;

import java.util.HashMap;
import java.util.HashSet;

public class Blok extends Instrukcja{
    private HashSet<String> zmienne = new HashSet<String>();
    private Instrukcja[] inst;
    public Blok(Instrukcja... inst){
        this.inst = inst;
    }
    @Override
    public void wykonaj() {
        for(Instrukcja i: inst){
            if(i instanceof Deklaracja){
                Deklaracja d = (Deklaracja) i;
                String tmp = d.getNazwa();
                if(zmienne.contains(tmp)) throw new IllegalArgumentException("zmienna o takiej nazwie już istnieje");
                zmienne.add(tmp);
            }
            i.wykonaj();
        }
        for(String nazwa: zmienne){
            Zmienna.usunZmienna(nazwa);
        }
        zmienne.clear();
    }

    @Override
    public String toString() {
        String result = "";
        for(Instrukcja i: inst){
            result+=i.toString();
            result+="\n";
        }
        return result;
    }
}
