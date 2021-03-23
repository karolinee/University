package obliczenia.instrukcje;

import obliczenia.Wyrazenie;

import java.util.Arrays;

public class WarunekIfElse extends WarunekIf{
    private  Instrukcja falsz;
    public WarunekIfElse(Wyrazenie warunek, Instrukcja prawda, Instrukcja falsz){
        super(warunek, prawda);
        if(falsz == null) throw new IllegalArgumentException("argumenty nie mogą być null");
        this.falsz = falsz;
    }
    @Override
    public void wykonaj() {
        if (warunek.oblicz() != 0){
            prawda.wykonaj();
        }
        else {
            falsz.wykonaj();
        }
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

        String tmp2 = falsz.toString();
        if(tmp2.contains("\n")){
            String[]lines = tmp2.split("\n");
            tmp2 = "";
            for(int i = 0; i < lines.length; i++){
                lines[i] = "  " + lines[i] + "\n";
                tmp2 += lines[i];
            }
        }
        else{
            tmp2 = "  " + tmp2 + "\n";
        }
        return "if (" + warunek.toString() + ") { \n" + tmp + "}\nelse { \n" + tmp2 + "}";
    }
}
