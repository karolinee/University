package testy;

import struktury.Para;
import struktury.ZbiorNaTablicyDynamicznej;

public class TestyTablicyDynamicznej {
    public static void test() {

        System.out.println("----------Testy implementacji zbioru na tablicy dynamicznej----------");
        
        //dodanie takiej samej wartości
        try {
            ZbiorNaTablicyDynamicznej zbior = new ZbiorNaTablicyDynamicznej();
            System.out.println(zbior.getLength());
            zbior.wstaw(new Para("a", 0));
            zbior.wstaw(new Para("b", 0));
            zbior.wstaw(new Para("c", 0));
            System.out.println(zbior.getLength());
            zbior.wstaw(new Para("c", 0));
            

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //usuniecie nieistniejącego klucza
        try {
            ZbiorNaTablicyDynamicznej zbior = new ZbiorNaTablicyDynamicznej();

            zbior.wstaw(new Para("a", 0));
            zbior.wstaw(new Para("b", 0));
            zbior.wstaw(new Para("c", 0));
            zbior.wstaw(new Para("d", 0));
            zbior.wstaw(new Para("e", 0));
            System.out.println(zbior.ile());
            zbior.usun("a");
            System.out.println(zbior.ile());
            zbior.usun("k");       

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //czytanie nieistniejącego klucza
        try {
            ZbiorNaTablicyDynamicznej zbior = new ZbiorNaTablicyDynamicznej();

            zbior.wstaw(new Para("a", 0));
            zbior.wstaw(new Para("b", 7));
            zbior.wstaw(new Para("c", 0));
            zbior.usun("a");
            System.out.println(zbior.czytaj("b"));
            System.out.println(zbior.czytaj("a"));
  

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //zmniejszanie
        try {
            ZbiorNaTablicyDynamicznej zbior = new ZbiorNaTablicyDynamicznej();

            zbior.wstaw(new Para("a", 0));
            zbior.wstaw(new Para("b", 7));
            zbior.wstaw(new Para("c", 0));
            zbior.wstaw(new Para("d", 0));
            zbior.wstaw(new Para("e", 0));
            System.out.println(zbior.getLength());
            zbior.usun("a");
            zbior.usun("b");
            zbior.usun("c");
            zbior.usun("d");
            System.out.println(zbior.getLength());

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //czyszczenie
        try {
            ZbiorNaTablicyDynamicznej zbior = new ZbiorNaTablicyDynamicznej();

            zbior.wstaw(new Para("a", 0));
            zbior.wstaw(new Para("b", 7));
            zbior.wstaw(new Para("c", 0));
            zbior.wstaw(new Para("d", 0));
            zbior.wstaw(new Para("e", 0));
            System.out.println(zbior.getLength());
            zbior.czysc();
            System.out.println(zbior.getLength());

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        

    }
}
