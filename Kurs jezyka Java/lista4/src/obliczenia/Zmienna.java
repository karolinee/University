package obliczenia;

import java.util.HashMap;

public class Zmienna extends Wyrazenie{
    private static final HashMap<String, Integer> variables = new HashMap<String, Integer>();
    private String zmienna;

    public Zmienna(String zmienna){
        this.zmienna = zmienna;
    }

    public static void dodajZmienna(String nazwa, int wartosc) {
        variables.put(nazwa, wartosc);
    }
    public static void wyczysc() {variables.clear();}
    public static boolean istniejeZmienna(String nazwa) {return variables.containsKey(nazwa);}
    public static void usunZmienna(String nazwa) {variables.remove(nazwa);}

    @Override
    public int oblicz() {
        if(!istniejeZmienna(zmienna)) throw new IllegalArgumentException("brak zmeinnej o takiej nazwie");
        return variables.get(zmienna);
    }

    @Override
    public String toString() {
        return zmienna;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == this) return true;
        if(obj == null || (this.getClass() != obj.getClass())) return false;
        Zmienna z = (Zmienna) obj;
        return this.zmienna.equals(z.zmienna);
    }
}
