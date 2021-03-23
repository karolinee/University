import java.awt.*;

public class FieldFinish extends Field
{
    public FieldFinish(Color color)
    {
        super(color);
        setVisible(false);
    }

    private void setPawnFinish(Pawn p) //ustawienie pionka na mecie
    {
        p.setX(5);
        p.setY(5);
        p.setPathPlace(44);
    }

    @Override
    protected void setPawn(Pawn p) //meta nie przechowuje pionka więc zamiast przypisywać do pola to tylko ustawia go na mecie
    {
        setPawnFinish(p);
    }
}
