import javax.swing.*;
import java.awt.*;

public class FieldBase extends Field
{

    public FieldBase(Color color)
    {
        super(color);
    }

    public Pawn removePawn() //usuwanie pioka z pola
    {
        Pawn p = getPawn();
        pawn = null;
        repaint();
        return p;
    }
}
