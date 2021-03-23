package obliczenia.op1arg.op2arg;

import obliczenia.Wyrazenie;

public class Potegowanie extends Operator2Arg{
    public Potegowanie(Wyrazenie w1, Wyrazenie w2) {
        super(w1, w2);
    }

    @Override
    public int oblicz() {
        return (int) Math.pow(w1.oblicz(), w2.oblicz());
    }

    @Override
    public String toString() {
        return "( " + w1.toString() + " ^ " + w2.toString() + " )";
    }
}
