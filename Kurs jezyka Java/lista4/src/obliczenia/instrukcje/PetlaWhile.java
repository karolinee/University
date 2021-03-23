package obliczenia.instrukcje;

import obliczenia.Wyrazenie;

public class PetlaWhile extends Instrukcja{
    private Wyrazenie warunek;
    private Instrukcja inst;

    public PetlaWhile(Wyrazenie warunek, Instrukcja inst){
        if(warunek == null || inst == null) throw new IllegalArgumentException("argumenty nie mogą być null");
        this.warunek = warunek;
        this.inst = inst;
    }
    @Override
    public void wykonaj() {
        while(warunek.oblicz() != 0){
            inst.wykonaj();
        }
    }

    @Override
    public String toString() {
        String tmp = inst.toString();
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
        return "while (" + warunek.toString() + ") \n{\n" + tmp + "}";
    }
}
