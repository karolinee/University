package obliczenia.op1arg;

import obliczenia.Wyrazenie;

public class ZmianaZnaku extends Operator1Arg {
    public ZmianaZnaku(Wyrazenie w) {
        super(w);
    }

    @Override
    public int oblicz() {
        return -w1.oblicz();
    }

    @Override
    public String toString() {
        return "(-" + w1.toString() +" )";
    }
}
