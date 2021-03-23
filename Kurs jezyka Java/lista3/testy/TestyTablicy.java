package testy;

import struktury.Para;
import struktury.ZbiorNaTablicy;

public class TestyTablicy {
    public static void test() {

        System.out.println("----------Testy implementacji zbioru na tablicy----------");
        //zbyt mały rozmiar zbioru
        try {
            ZbiorNaTablicy zbior = new ZbiorNaTablicy(1);
            zbior.wstaw(new Para("a", 0));

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //dodanie wartości ponad rozmiar zbioru
        try {
            ZbiorNaTablicy zbior = new ZbiorNaTablicy(2);

            zbior.wstaw(new Para("a", 0));
            zbior.wstaw(new Para("b", 0));
            zbior.wstaw(new Para("c", 0));

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //dodanie takiej samej wartości
        try {
            ZbiorNaTablicy zbior = new ZbiorNaTablicy(4);

            zbior.wstaw(new Para("a", 0));
            zbior.wstaw(new Para("b", 0));
            zbior.wstaw(new Para("a", 0));

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //usuniecie nieistniejącego klucza
        try {
            ZbiorNaTablicy zbior = new ZbiorNaTablicy(4);

            zbior.wstaw(new Para("a", 0));
            zbior.wstaw(new Para("b", 0));
            zbior.wstaw(new Para("c", 0));
            System.out.println(zbior.ile());
            zbior.usun("a");
            System.out.println(zbior.ile());
            zbior.usun("k");

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //czytanie nieistniejącego klucza
        try {
            ZbiorNaTablicy zbior = new ZbiorNaTablicy(4);

            zbior.wstaw(new Para("a", 1));
            zbior.wstaw(new Para("b", 2.78905));
            zbior.wstaw(new Para("c", 3));
            zbior.usun("a");
            System.out.println(zbior.czytaj("b"));
            System.out.println(zbior.czytaj("a"));

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //aktualizacja pary
        try {
            ZbiorNaTablicy zbior = new ZbiorNaTablicy(4);

            zbior.wstaw(new Para("a", 1));
            zbior.wstaw(new Para("b", 2));
            zbior.wstaw(new Para("c", 3));
            System.out.println(zbior.czytaj("a"));
            System.out.println(zbior.ile());
            zbior.ustaw(new Para("a", 4));
            System.out.println(zbior.czytaj("a"));
            System.out.println(zbior.ile());
            zbior.ustaw(new Para("d", 5));
            System.out.println(zbior.ile());
            zbior.ustaw(new Para("e", 6));

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //czyszczenie
        try {
            ZbiorNaTablicy zbior = new ZbiorNaTablicy(4);

            zbior.wstaw(new Para("a", 1));
            zbior.wstaw(new Para("b", 2));
            zbior.wstaw(new Para("c", 3));
            System.out.println(zbior.czytaj("a"));
            System.out.println(zbior.ile());
            zbior.czysc();
            System.out.println(zbior.ile());
            System.out.println(zbior.czytaj("a"));
            

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }


        
        
    }
}
