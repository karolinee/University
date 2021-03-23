import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;

public class Game extends JFrame
{
    private Player[] players = new Player[4]; //gracze - zawsze 4
    private Board board; //plansza
    private int playerTurn; //tura którego gracza
    private Dice dice; //kostka
    private JTextField tTurn; //informacja o tym, którego gracza jest aktualnie tura
    private JPanel pSpace; //dodatkowe miejsce w ramce na informacje (o turze i kostce)

    public Game()
    {
        setFrame(); //ustawienie ramki - plansza i miejsce na informacje
        setPlayers(); //ustawienie grzacz (czterech)
        setPawns(); //ustawienie pionków graczy w bazie

        playerTurn = 0;
    }

    private void setFrame()
    {

        setLayout(new FlowLayout());

        board = new Board();
        add(board);


        pSpace = new JPanel();
        pSpace.setLayout(new BoxLayout(pSpace,BoxLayout.Y_AXIS));
        pSpace.setPreferredSize(new Dimension(300,100));
        pSpace.setBorder(new EmptyBorder(new Insets(20, 20, 20, 20)));

        tTurn = new JTextField("Tura .. gracza");
        tTurn.setBounds(new Rectangle(200,50));
        tTurn.setHorizontalAlignment(JTextField.CENTER);
        pSpace.add(tTurn);
        dice = new Dice();
        pSpace.add(dice);

        add(pSpace);


        pack();
        setTitle("Chińczyk");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setResizable(false);
        setLocationRelativeTo(null);
        setVisible(true);
    }

    private void setPlayers()
    {
        players[0] = new Player(Color.RED);
        players[1] = new Player(Color.YELLOW);
        players[3] = new Player(Color.BLUE);
        players[2] = new Player(Color.GREEN);

        for(int i = 0; i<4;i++)
        {
            players[i].setBase(board.getBase(players[i].getPawns()));
        }
    }

    private void setPawns()
    {
        for(int i = 0; i < 4; i++)
        {
            board.addToHomes(players[i].getPawns());
        }
    }

    public void run()
    {
        int i = 0; //ile ruchów z rzędu 1 gracza
        while(true)
        {
            i++;
            setTurnText(); //ustawinie informacji czyja tura
            int r = dice.roll();

            //chwila czekania(jakby gracz nie miał ruchu by można przeczytać ile wyrzucił
            try
            {
                Thread.sleep(1000);
            }
            catch(InterruptedException ex)
            {
                Thread.currentThread().interrupt();
            }

            board.setMove(players[playerTurn].getColor(),r); //ustawienie zmiennych w klasie board, informujących czyj ruch i o ile
            if(board.validMove(players[playerTurn])) //sprawdzamy czy gracz może wykonać jakikolwiek ruch
            {
                while(!board.getCont()) //czekanie na ruch gracza
                {
                    try
                    {
                        Thread.sleep(1);
                    }
                    catch(InterruptedException ex)
                    {
                        Thread.currentThread().interrupt();
                    }
                }
            }

            if(players[playerTurn].finish()) //jeden z graczy ma wszystkie pioniki na mecie -koniec gry
                endGame();

            if(r!=6 || i == 3) //sprawdzenie czy gracz wyrzucił szóstkę (wtedy powtarza rundę) i czy nie przekroczył maksymalnej ilości powtórzeń rundy
            {
                i = 0;
                playerTurn++;
                if(playerTurn == 4) playerTurn = 0;
            }
        }
    }

    private void setTurnText() //ustawienie tektu informującego o turze
    {
        String s = "";

        switch(playerTurn)
        {
            case(0):
                s = "czerwonego";
                break;
            case(1):
                s = "żółtego";
                break;
            case(2):
                s = "zielonego";
                break;
            case(3):
                s = "niebieskiego";
                break;
        }

        tTurn.setText("Tura " + s + " gracza: ");
    }

    private void endGame() //wyskakujące okienko informujące który gracz wygrał grę, kończy program
    {
        String s = "";

        switch(playerTurn)
        {
            case(0):
                s = "czerwony";
                break;
            case(1):
                s = "żółty";
                break;
            case(2):
                s = "zielony";
                break;
            case(3):
                s = "niebieski";
                break;
        }

        JOptionPane.showMessageDialog(null,"Wygrał gracz " + s,"KONIEC GRY",JOptionPane.INFORMATION_MESSAGE);
        System.exit(0);

    }
}
