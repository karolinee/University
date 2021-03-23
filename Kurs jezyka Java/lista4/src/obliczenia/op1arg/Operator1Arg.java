package obliczenia.op1arg;

import obliczenia.Wyrazenie;
import obliczenia.op1arg.op2arg.Operator2Arg;

public abstract class Operator1Arg extends Wyrazenie {
    protected Wyrazenie w1;

    public Operator1Arg(Wyrazenie w1){
        this.w1 = w1;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == this) return true;
        if(obj == null || (this.getClass() != obj.getClass())) return false;
        Operator1Arg o = (Operator1Arg) obj;
        return this.w1.equals(o.w1);
    }
}
