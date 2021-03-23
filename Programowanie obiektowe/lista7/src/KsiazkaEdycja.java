import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.io.Serializable;
import java.io.*;

public class KsiazkaEdycja extends JFrame implements ActionListener, Serializable {
    private Ksiazka k;
    private JFrame frame;
    private Container kontener;
    private JTextField autor, tytul, wydanie;
    private  JLabel autor_etykieta, tytul_etykieta, wyadanie_etykieta;
    private JButton button;
    private GridLayout layout;
    private String filename;

    public KsiazkaEdycja(String name){

        filename = name;
        k = Read();

        if( k == null)
        {
            k = new Ksiazka();
        }

        frame = new JFrame("Edycja książki");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        kontener = frame.getContentPane();
        layout = new GridLayout(4,2);
        kontener.setLayout(layout);

        autor = new JTextField(k.autor,10);
        tytul = new JTextField(k.tytul,10);
        wydanie = new JTextField(Integer.toString(k.wydanie),10);

        autor_etykieta = new JLabel("Autor: ");
        tytul_etykieta = new JLabel("Tytuł: ");
        wyadanie_etykieta = new JLabel("Rok wydania: ");

        kontener.add(autor_etykieta);
        kontener.add(autor);
        kontener.add(tytul_etykieta);
        kontener.add(tytul);
        kontener.add(wyadanie_etykieta);
        kontener.add(wydanie);

        button = new JButton("Zapisz");
        button.addActionListener((ActionListener) this);
        kontener.add(button);

        frame.pack();
        frame.setVisible(true);
    }

    public void actionPerformed (ActionEvent ev) {

        k.autor = autor.getText();
        k.wydanie = Integer.parseInt(wydanie.getText());
        k.tytul = tytul.getText();
        System.out.println(k);
        Save(k);

        frame.setVisible(false);
        dispose();
    }
    private void Save (Ksiazka toSave) {
        try {
            FileOutputStream file = new FileOutputStream(filename);
            ObjectOutputStream out = new ObjectOutputStream(file);
            out.writeObject(toSave);
            out.close();
            file.close();
        } catch (IOException ex) {
            System.out.println("Saving failed");
        }
    }
    private Ksiazka Read() {
        try {
            FileInputStream file = new FileInputStream(filename);
            ObjectInputStream in = new ObjectInputStream(file);
            Ksiazka read = (Ksiazka)in.readObject();
            in.close();
            file.close();
            return read;
        }
        catch (IOException ex) {
            return null;
        }
        catch (ClassNotFoundException ex) {
            return null;
        }
    }


}

