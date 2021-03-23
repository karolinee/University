package obliczenia.op1arg.op2arg;

import obliczenia.Wyrazenie;

public class Dzielenie extends Operator2Arg{
    public Dzielenie(Wyrazenie w1, Wyrazenie w2) {
        super(w1, w2);
    }

    @Override
    public int oblicz() {
        int dzielnik = w2.oblicz();
        if(dzielnik == 0) throw new ArithmeticException("dzielenie przez 0");
        return w1.oblicz() / dzielnik;
    }

    @Override
    public String toString() {
        return "( " + w1.toString() + " / " + w2.toString() + " )";
    }
}
