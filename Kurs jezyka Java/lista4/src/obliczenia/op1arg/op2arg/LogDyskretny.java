package obliczenia.op1arg.op2arg;

import obliczenia.Wyrazenie;

public class LogDyskretny extends Operator2Arg{
    public LogDyskretny(Wyrazenie w1, Wyrazenie w2) {
        super(w1, w2);
    }

    @Override
    public int oblicz() {
       double arg1 = w1.oblicz();
       double arg2 = w2.oblicz();
       if(arg1 <= 1) throw new IllegalArgumentException("podstawa logarytmu musi być większa od 1");
       if(arg2 <= 0) throw new IllegalArgumentException("liczba logarytmowana musi być dodatnia");
       double result = Math.log(arg2) / Math.log(arg1);
       if(result != (int)result) throw new ArithmeticException("logarytm dyskretny dla tych liczb nie istnieje");
       return (int) result;
    }

    @Override
    public String toString() {
        return "log(" + w1.toString() + ", " + w2.toString() + ")";
    }
}
