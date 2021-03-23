import java.awt.*;

public class Player {

    private Pawn[] pawns = new Pawn[4]; //pionki gracza
    private Color color; //kolor gracza
    private Home base;

    public Player(Color color)
    {
        this.color = color;
        setPawns();
    }

    private void setPawns() //tworzenie pionków gracza
    {
        for(int i = 0; i < 4 ; i++)
        {
            pawns[i] = new Pawn(color);
        }
    }
    public  void setBase(FieldBase[] f)
    {
        base = new Home(f);
    }

    public Home getBase() {
        return base;
    }

    public Pawn[] getPawns()
    {
        return pawns;
    }

    public Color getColor() {
        return color;
    }

    public boolean finish() //sprawdza czy wszystkie pionki gracza są na mecie
    {
        int p = 0;
        for(int i = 0; i < 4; i++)
        {
            if(pawns[i].finish())
                p++;
        }

        return (p == 4);
    }
}
