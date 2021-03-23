import javax.swing.*;
import java.awt.*;
import java.util.Random;


public class Dice extends JTextField{

    Random gen;

    public Dice()
    {
        gen = new Random();
        setBounds(new Rectangle(200,50));
        setHorizontalAlignment(JTextField.CENTER);
    }

    public int roll()
    {
        int r = gen.nextInt(6) + 1; //losowanie liczy 1...6
        setText(r); //ustawnienie tekstu
        return r;
    }

    private void setText(int r) //ustawienie tekstu z informacja ile wyrzucono na kostce
    {
        setText("wyrzucono " + r);
    }
}