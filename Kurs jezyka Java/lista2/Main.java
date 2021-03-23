public class Main
{
    public static void main (String[] args) throws Exception
    {
        //tworzenie obiektów i override ToString
        Punkt p1 = new Punkt(3,2);
        Punkt p2 = new Punkt(7,6);

        Punkt p3 = new Punkt(3,2);
        Punkt p4 = new Punkt(7,6);
        Punkt p5 = new Punkt(1,10);

        Prosta p = new Prosta(0,1,0); //ox

        Wektor w = new Wektor(2,2);
        Wektor v = new Wektor(-1,3);
        
        Odcinek o = new Odcinek(p1, p2);

        Trojkat t = new Trojkat(p3, p4, p5);

        System.out.println("------------------------Tworzenie odcinke i trójkąta - wyjątki");
        try {
            Odcinek o2 = new Odcinek(p1,p1);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            Trojkat t2 = new Trojkat(p1, new Punkt(3, 5), new Punkt(3, 8));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        System.out.println("------------------------Funkcje punktu, odcinka i trójkąta");
        System.out.println(o);
        System.out.println(t);
        System.out.println("------Przesunięcie odcinka o: " + w + "zlożone z " + v);
        o.przesun(Wektor.zloz(w, v));
        System.out.println(o);

        System.out.println("------Obrót odcinka wokół środku układu o kąt 180");
        o.obroc(new Punkt(0,0), 180);
        System.out.println(o);

        System.out.println("------Odbicie trójkąta według: " + p);
        t.odbij(p);
        System.out.println(t);
    }
}