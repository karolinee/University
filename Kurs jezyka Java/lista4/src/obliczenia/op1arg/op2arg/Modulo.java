package obliczenia.op1arg.op2arg;

import obliczenia.Wyrazenie;

public class Modulo extends Operator2Arg{
    public Modulo(Wyrazenie w1, Wyrazenie w2) {
        super(w1, w2);
    }

    @Override
    public int oblicz() {
        int arg1 = w1.oblicz();
        int arg2 = w2.oblicz();
        if(arg2 == 0) throw new IllegalArgumentException("dzielenie przez 0");
        return arg1 % arg2;
    }

    @Override
    public String toString() {
        return "( " + w1.toString() + " mod " + w2.toString() + " )";
    }
}
