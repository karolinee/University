abstract class Wyrazenie {
    protected Wyrazenie lewe;
    protected Wyrazenie prawe;

    public abstract int oblicz();

    public abstract Wyrazenie pochodna();

    public static void main(String[] args)
    {
        Wyrazenie p1 = new Pomnoz(new Dodaj(new Zmienna("x"),new Stala(2)), new Stala(5));

        System.out.println(p1);
        System.out.println(p1.oblicz());

        System.out.println(p1.pochodna());
    }



}
