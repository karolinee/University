import obliczenia.*;
import obliczenia.instrukcje.*;
import obliczenia.op1arg.Silnia;
import obliczenia.op1arg.ZmianaZnaku;
import obliczenia.op1arg.op2arg.*;

public class Main {
    public static void main(String[] args){
        Zmienna.dodajZmienna("x", 2);
        Zmienna.dodajZmienna("y", 1);

        //3+5
        Wyrazenie w1 = new Dodawanie(new Liczba(3), new Liczba(5));
        System.out.println(w1 + " = " + w1.oblicz());

        //-(2-x)*7
        Wyrazenie w2 = new Mnozenie(new ZmianaZnaku(new Odejmowanie(new Liczba(2), new Zmienna("x"))), new Liczba(7));
        System.out.println(w2 + " = " + w2.oblicz());

        //(3 * 11 - 1) / (7 + 5)
        Wyrazenie w3 = new Dzielenie(new Odejmowanie(new Mnozenie(new Liczba(3), new Liczba(11)), new Liczba(1)), new Dodawanie(new Liczba(7), new Liczba(5)));
        System.out.println(w3 + " = " + w3.oblicz());

        //min((x + 13) * x, (1 - x) mod 2)
        Wyrazenie w4 = new Minimum(new Mnozenie(new Dodawanie(new Zmienna("x"), new Liczba(13)), new Zmienna("x")), new Modulo(new Odejmowanie(new Liczba(1), new Zmienna("x")), new Liczba(2)));
        System.out.println(w4 + " = " + w4.oblicz());

        //2 ^ 5 + x * log(2, y) < 20
        Wyrazenie w5 = new Mniejsze(new Dodawanie(new Potegowanie(new Liczba(2), new Liczba(5)), new Mnozenie(new Zmienna("x"), new LogDyskretny(new Liczba(2), new Zmienna("y")))), new Liczba(20));
        System.out.println(w5 + " = " + w5.oblicz());

        Zmienna.wyczysc();
        Zmienna.wyczysc();

        Instrukcja i = new Blok(
                new Deklaracja("n"),
                new Czytaj("n"),
                new WarunekIfElse(
                        new Mniejsze(new Zmienna("n"), new Liczba(2)),
                        new Wypisz(0),
                        new Blok(
                                new Deklaracja("p"),
                                new Przypisanie("p", new Liczba(2)),
                                new Deklaracja("wyn"),
                                new PetlaWhile(
                                        new MniejszeRowne(new Mnozenie(new Zmienna("p"), new Zmienna("p")), new Zmienna("n")),
                                        new Blok(
                                                new WarunekIf(
                                                        new Rowne(new Modulo(new Zmienna("n"), new Zmienna("p")), new Liczba(0)),
                                                        new Blok(
                                                                new Przypisanie("wyn", new Zmienna("p")),
                                                                new Przypisanie("p", new Zmienna("n"))
                                                        )),
                                                new Przypisanie("p", new Dodawanie(new Zmienna("p"), new Liczba(1))))),
                                new WarunekIfElse(
                                        new Wieksze(new Zmienna("wyn"), new Liczba(0)),
                                        new Wypisz(0),
                                        new Wypisz(1)))
                        )
                );
        Instrukcja wh = new PetlaWhile(new Stala("1"), i);

        System.out.println(i);
        wh.wykonaj();

    }
}
