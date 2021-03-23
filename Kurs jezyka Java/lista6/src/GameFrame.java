import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

public class GameFrame extends Frame {
    GameCanvas game;
    public GameFrame() {
        super("MAZE GAME");
        setSize(810, 850);

        addWindowListener(new WindowClose());

        setLayout(new GridBagLayout());
        game = new GameCanvas(25, 25jav);
        add(game);

        setVisible(true);
    }

    private class WindowClose extends WindowAdapter
    {
        @Override
        public void windowClosing (WindowEvent ev)
        {
            GameFrame.this.dispose();
        }
    }
}
