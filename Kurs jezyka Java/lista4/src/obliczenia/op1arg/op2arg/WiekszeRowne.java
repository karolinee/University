package obliczenia.op1arg.op2arg;

import obliczenia.Wyrazenie;

public class WiekszeRowne extends Operator2Arg{
    public WiekszeRowne(Wyrazenie w1, Wyrazenie w2) {
        super(w1, w2);
    }

    @Override
    public int oblicz() {
        return w1.oblicz() >= w2.oblicz() ? 1 : 0;
    }

    @Override
    public String toString() {
        return w1.toString() + " >= " + w2.toString();
    }
}
