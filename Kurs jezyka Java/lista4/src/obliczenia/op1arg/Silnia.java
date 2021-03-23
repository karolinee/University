package obliczenia.op1arg;

import obliczenia.Wyrazenie;

public class Silnia extends Operator1Arg {
    public Silnia(Wyrazenie w1) {
        super(w1);
    }

    @Override
    public int oblicz() {
        int arg = w1.oblicz();
        if(arg < 0) throw new IllegalArgumentException("argument silni musi być nieujemny");
        int res = 1;
        for(int i = 2; i <= arg; i++){
            res *= i;
        }
        return res;
    }

    @Override
    public String toString() {
         return "( " + w1.toString() + "! )";
    }
}
