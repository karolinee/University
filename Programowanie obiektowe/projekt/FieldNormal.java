import java.awt.*;

public class FieldNormal extends Field {

    public FieldNormal(Color color)
    {
        super(color);
    }

    public Pawn removePawn() //usuwanie pionka z pola
    {
        Pawn p = getPawn();
        pawn = null;
        return p;
    }
}
