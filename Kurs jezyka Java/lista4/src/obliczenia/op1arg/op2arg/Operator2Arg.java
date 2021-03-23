package obliczenia.op1arg.op2arg;

import obliczenia.Wyrazenie;
import obliczenia.op1arg.Operator1Arg;

public abstract class Operator2Arg extends Operator1Arg {
    protected Wyrazenie w2;
    public Operator2Arg(Wyrazenie w1, Wyrazenie w2) {
        super(w1);
        this.w2 = w2;
    }
    @Override
    public boolean equals(Object obj) {
        if(obj == this) return true;
        if(obj == null || (this.getClass() != obj.getClass())) return false;
        Operator2Arg o = (Operator2Arg) obj;
        return (this.w1.equals(o.w1)) && (this.w2.equals(o.w2));
    }
}
