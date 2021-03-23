package obliczenia.instrukcje;

import obliczenia.Wyrazenie;

import java.lang.reflect.Array;
import java.util.Arrays;

public class WarunekIf extends Instrukcja{
    protected Wyrazenie warunek;
    protected Instrukcja prawda;
    public WarunekIf(Wyrazenie warunek, Instrukcja prawda){
        if(warunek == null || prawda == null) throw new IllegalArgumentException("argumenty nie mogą być null");
        this.warunek = warunek;
        this.prawda = prawda;
    }
    @Override
    public void wykonaj() {
        if(warunek.oblicz() != 0)   prawda.wykonaj();
    }

    @Override
    public String toString() {
        String tmp = prawda.toString();
        if(tmp.contains("\n")){
            String[]lines = tmp.split("\n");
            tmp = "";
            for(int i = 0; i < lines.length; i++){
                lines[i] = "  " + lines[i] + "\n";
                tmp += lines[i];
            }
        }
        else{
            tmp = "  " + tmp + "\n";
        }
        return "if (" + warunek.toString() + ") {\n" + tmp + "}";
    }
}
