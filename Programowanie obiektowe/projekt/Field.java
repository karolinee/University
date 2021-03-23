import javax.swing.*;
import java.awt.*;


public class Field extends JButton
{
    protected Color color; //kolor pola
    protected Dimension size = new Dimension(50,50); //rozmiar pola

    protected Pawn pawn; //pionek który na polu stoi

    public Field(Color color)
    {
        this.color = color;
        setMargin(new Insets(0,00,0,0));
        setBackground(color);
        setPreferredSize(size);

        pawn = null;
    }

    @Override
    public void paintComponent(Graphics g)
    {
        super.paintComponent(g);
        if(hasPawn()) //jeśli na polu znajduje się pionek to go rysujemy
        {
            g.setColor(Color.BLACK);
            g.drawOval(9,9,32,32);
            g.setColor(pawn.getColor());
            g.fillOval(10, 10, 30, 30 );
        }
    }

    protected boolean hasPawn() //sprawdzanie czy na polu stoi pionek
    {
        return (pawn!=null);
    }

    protected void setPawn(Pawn pawn)
    {
        this.pawn = pawn;
    }
    protected Pawn getPawn()
    {
        return pawn;
    }

    public Color getColor()
    {
        return color;
    }
}
