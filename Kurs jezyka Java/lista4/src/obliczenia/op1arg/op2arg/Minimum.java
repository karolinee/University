package obliczenia.op1arg.op2arg;

import obliczenia.Wyrazenie;

public class Minimum extends Operator2Arg{

    public Minimum(Wyrazenie w1, Wyrazenie w2) {
        super(w1, w2);
    }

    @Override
    public int oblicz() {
        return Math.min(w1.oblicz(), w2.oblicz());
    }

    @Override
    public String toString() {
        return "min( " + w1.toString() + ", " + w2.toString() + ")";
    }
}
