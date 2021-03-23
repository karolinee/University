package obliczenia;

public abstract class Wyrazenie implements Obliczalny{

    public static int suma(Wyrazenie... wyr){
        int sum = 0;
        for(Wyrazenie w: wyr){
            sum += w.oblicz();
        }
        return sum;
    }

    public static int iloczyn(Wyrazenie... wyr){
        int product = 1;
        for(Wyrazenie w: wyr){
            product *= w.oblicz();
        }
        return product;
    }
}
