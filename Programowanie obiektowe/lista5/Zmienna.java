import java.util.Hashtable;

public class Zmienna extends Wyrazenie{
    String symbol;

    private static Hashtable<String, Integer> h = new Hashtable<String, Integer>(){{
        put("x",3);
        put("y",7);
        put("z",4);
    }};

    public Zmienna(String symbol)
    {
        this.symbol = symbol;
        this.lewe = null;
        this.prawe = null;
    }

    public int oblicz()
    {
        return h.get(symbol);
    }
    public String toString() {
        return this.symbol;
    }

    public Wyrazenie pochodna()
    {
        return new Stala(1);
    }
}
