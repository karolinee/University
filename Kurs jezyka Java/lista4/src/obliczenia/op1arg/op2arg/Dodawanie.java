package obliczenia.op1arg.op2arg;

import obliczenia.Wyrazenie;
import obliczenia.op1arg.ZmianaZnaku;

public class Dodawanie extends Operator2Arg{

    public Dodawanie(Wyrazenie w1, Wyrazenie w2) {
        super(w1, w2);
    }

    @Override
    public int oblicz() {
        return w1.oblicz() + w2.oblicz();
    }

    @Override
    public String toString() {
        return "( " + w1.toString() + " + " + w2.toString() + " )";
    }
}
