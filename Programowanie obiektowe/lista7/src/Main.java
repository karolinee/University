import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Main{

        public static void main(String[] args)
        {
            JFrame frame;
            switch (args[1]) {
                case "Ksiazka":
                    frame = new KsiazkaEdycja(args[0]);
                    break;
                case "Czasopismo":
                    frame = new CzasopismoEdycja(args[0]);
                    break;
                case "WydawnictwoCiagle":
                    frame = new WydawnictwoCiagleEdycja(args[0]);
                    break;
                default:
                    System.out.println("Brak takiej klasy!");
            }
        }
}

