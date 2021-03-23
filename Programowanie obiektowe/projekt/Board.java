import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Board extends JPanel implements ActionListener
{
    private JButton fields[][] = new JButton[11][11]; //tablica 2D reprezentująca wszystkie pola na planszy
    Field clicked;

    //kolory pól
    Color yellow = Color.YELLOW;
    Color red = Color.RED;
    Color green = Color.GREEN;
    Color blue = Color.BLUE;
    Color white = Color.WHITE;
    Color none = null;


    //zmienne pomocnicze do wykoniania ruchu pionka
    private Color moveColor; //jaki kolor wykonuje ruch
    private boolean cont; //czy ruch został wykonany
    private int moveNumber; //o ile pionek ma się poruszyć
    private boolean madeMove;


    public Board()
    {
        setLayout(new GridLayout(11,11,3,3));

        setFields();

        moveColor = null;
        cont = false;

    }

    private void setFields()
    {
        for(int i = 0; i < 11 ; i++)
        {
            for(int j = 0; j < 11 ; j++)
            {
                JButton a;

                //"tło"
                if((i >= 2 && i < 4 && j < 4) || (j >= 2 && j < 4 && i < 4) ||
                        (i >= 2 && i < 4 && j > 6) || (j >= 7 && j < 9 && i < 4) ||
                        (i >= 7 && i < 9 && j < 4) || (j >= 2 && j < 4 && i > 6) ||
                        (i >= 7 && i < 9 && j > 6) || (j >= 7 && j < 9 && i > 6))

                {
                    a = new Field(null);
                    a.setEnabled(false);
                    a.setVisible(false);
                }
                //bazy pionków
                else if(i<2 && j < 2)
                {
                    a = new FieldBase(red);
                }
                else if(i<2 && j >= 9)
                {
                    a = new FieldBase(yellow);
                }
                else if(i>=9 && j < 2)
                {
                    a = new FieldBase(blue);
                }
                else if(i>=9 && j>=9)
                {
                    a = new FieldBase(green);
                }
                //meta
                else if(i == 5 && j == 5)
                {
                    a = new FieldFinish(none);
                }
                //końcowe pola przed meta (wyróżnione bo maja inne kolory)
                else if((i == 4 && j==0 ) || (i == 5 && j < 5 && j>0))
                {
                    a = new FieldNormal(red);
                }
                else if((i==6 && j == 10) || (i == 5 && j > 5 && j<10))
                {
                    a = new FieldNormal(green);
                }
                else if ((i == 0 && j == 6) || (j == 5 && i > 0 && i < 5))
                {
                    a = new FieldNormal(yellow);
                }
                else if((i == 10 && j == 4) || (j == 5 && i> 5 && i < 10))
                {
                    a = new FieldNormal(blue);
                }
                //normalne pola na planszy
                else
                {
                    a = new FieldNormal(white); //zwykle pole
                }

                a.addActionListener(this);
                add(a);
                fields[i][j] = a;
            }
        }
    }

    //dodanie pionków do baz
    public void addToHomes(Pawn[] pawns)
    {
        Color c = pawns[0].getColor();
        int[][] home = pawns[0].getHome();

        for (int i = 0; i < 4; i++) {
            int x = home[i][0];
            int y = home[i][1];
            Field f = (FieldBase) fields[x][y];
            f.setPawn(pawns[i]);
            pawns[i].setX(x);
            pawns[i].setY(y);
            pawns[i].setPathPlace(-1);
        }
    }
    //baza pionków
    public FieldBase[] getBase(Pawn[] p)
    {
        int[][] home = p[0].getHome();
        FieldBase[] f = new FieldBase[4];

        for(int i = 0; i<4;i++)
        {
            int x = home[i][0];
            int y = home[i][1];

            f[i] = (FieldBase)fields[x][y];
        }

        return f;
    }

    //ustawnie zmiennych odpowiadających za ruch pionka
    public void setMove(Color color, int i)
    {
        moveColor = color;
        cont = false;
        moveNumber = i;
        madeMove = false;
    }


    @Override
    public void actionPerformed(ActionEvent e) {
        Field source = (Field) e.getSource();

        if(source.hasPawn() && source.getPawn().getColor() == moveColor && madeMove == false)
        {
            if(source instanceof FieldBase) //wyjscie pionka z bazy
            {
                if(moveNumber == 6)
                {

                    Field to;
                    int x, y;
                    int[][] path = source.getPawn().getPath();
                    x = path[0][0];
                    y = path[0][1];

                    to = (Field)fields[x][y];
                    if(!(to.hasPawn() && to.getPawn().getColor() == source.getPawn().getColor()))
                    {
                        out((FieldBase)source);
                        cont = true;
                        madeMove = true;
                    }
                }
            }
            else
            {
                int xs,ys,xd,yd, temp;

                //wzięcie aktualnych współrzędnych pionka
                xs = source.getPawn().getX();
                ys = source.getPawn().getY();

                //wziecie ścieżki pionka
                int[][] path = source.getPawn().getPath();

                //wzięcie pozycji na trasie
                temp = source.getPawn().getPathPlace();

                //nowa pozycja na trasie
                temp += moveNumber;
                if(temp < 45) //czy nie wychodzimy poza trasę
                {
                    //współrzędne docelowe
                    xd = path[temp][0];
                    yd = path[temp][1];
                    Field f = (Field) fields[xd][yd]; //pole docelowe

                    if(!(f.hasPawn() && f.getPawn().getColor() == source.getPawn().getColor())) //sprawdzanie czy na polu docelowym nie ma pionka o takim samym kolorze
                    {
                        //ustawnienie nowych współrzednych pionka
                        source.getPawn().setY(yd);
                        source.getPawn().setX(xd);
                        source.getPawn().setPathPlace(temp);

                        //ruch
                        move(source,f);
                        cont = true;
                        madeMove = true;
                    }
                }
            }
        }
    }

    //sprawdzenie czy można wykonać jakikolwiek ruch
    public boolean validMove(Player p)
    {
        if(p.getBase().allHome() && moveNumber!=6) //wszstkie pionki w bazie a nie ma 6
            return false;


        Pawn[] pawns = p.getPawns();

        int[] pp = new int[4]; //pozycje pionków
        for(int i = 0; i < 4 ;i++)
        {
            Pawn pa = pawns[i];

            pp[i] = pa.getPathPlace();
        }

        int freeToMove = 0; //ile pionkow w polu może się ruszyć
        for(int i = 0; i<4; i++)
        {
            if(pp[i]!=-1)
            {
                int npp = pp[i] + moveNumber;
                if(npp < 45)
                {
                    for(int j = 0; j < 4; j++)
                    {
                        if(pp[j] != npp) //ile pionków może się ruszyć
                        {
                            freeToMove++;
                        }
                    }
                }
            }

        }

        boolean onOut = false;
        if(moveNumber == 6 && p.getBase().anyHome()) //czy jakiś pionek zastawia wyjście z bazy
        {
            for(int i = 0; i<4; i++)
            {
                if(pp[i] == 0)
                {
                    onOut = true;
                    break;
                }
            }
        }

        return ((!onOut && (moveNumber == 6)) || !(freeToMove == 0));
    }

    //wyjście pionka z bazy
    private void out(FieldBase from)
    {
        Pawn p = from.removePawn();

        Field to;
        int x, y;
        int[][] path = p.getPath();
        x = path[0][0];
        y = path[0][1];

        to = (Field)fields[x][y];
        if(to.hasPawn()) //zbicie pionka
        {
            moveHome(to);
        }
        to.setPawn(p);
        p.setPathPlace(0);
        to.repaint();
    }

    //ustawnie zbitego pionka w bazie
    private void moveHome(Field from)
    {
        int[][] home = from.getPawn().getHome();

        Pawn p = ((FieldNormal) from).removePawn();

        for(int i = 0; i < 4; i++)
        {
            int x = home[i][0];
            int y = home[i][1];
            FieldBase f = (FieldBase) fields[x][y];
            if(!f.hasPawn()) //szukanie wolnego miejsca w bazie
            {
                f.setPawn(p);
                f.repaint();
                break;
            }
        }
    }

    //zwykłe poruszanie pionkiem
    private void move(Field from, Field to)
    {
        Pawn p = from.getPawn();
        from.setPawn(null);
        from.repaint();

        if(to.hasPawn() && !(to instanceof FieldFinish)) //zbicie pionka
        {
            moveHome(to);
        }
        to.setPawn(p);
        to.repaint();

    }

    //metoda zwracająca zmienną continue(czy ruch został wykonany)
    public boolean getCont()
    {
        return cont;
    }


}
