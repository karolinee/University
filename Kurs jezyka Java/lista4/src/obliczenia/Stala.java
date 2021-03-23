package obliczenia;

import obliczenia.op1arg.Operator1Arg;

import java.util.HashMap;

public class Stala extends Wyrazenie {
    private static final HashMap<String, Integer> stale = new HashMap<String, Integer>();
    static {
        stale.put("0", 0);
        stale.put("1", 1);
        stale.put("-1", -1);
    }
    private String nazwa;

    public Stala(String nazwa){
        this.nazwa = nazwa;
    }
    @Override
    public int oblicz() {
        return stale.get(nazwa);
    }

    @Override
    public String toString() {
        return nazwa;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == this) return true;
        if(obj == null || (this.getClass() != obj.getClass())) return false;
        Stala s = (Stala) obj;
        return this.nazwa.equals(s.nazwa);
    }
}
