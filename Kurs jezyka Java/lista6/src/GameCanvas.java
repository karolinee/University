import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

public class GameCanvas extends Canvas {
    private final int height, width;
    private final int offsetX, offsetY;

    private final Maze maze;
    private final Player player;

    public GameCanvas(int height, int width){
        this.height = height;
        this.width = width;
        this.offsetX = 800/height;
        this.offsetY = 800/width;
        maze = new Maze(height, width);
        player = new Player(height, width);

        setBackground (Color.WHITE);
        setSize(801, 801);
        addKeyListener(new KeyClicked());
        setFocusable(true);
        requestFocus();
    }

    private boolean canMove(Maze.Direction dir){
        int x = player.getX();
        int y = player.getY();
        return !maze.hasWall(x, y, dir);
    }

    private boolean finished(){
        if((player.getX() == 0) && (player.getY() == 0)) return true;
        return false;
    }

    @Override
    public void paint(Graphics g) {
        paintMaze(g);
        paintPlayer(g);
    }
    public void paintMaze(Graphics g) {
        g.setColor(Color.black);
        for(int i = 0; i < height; i++){
            for(int j = 0; j < width; j++){
                if(maze.hasWall(i,j, Maze.Direction.UP)) g.drawLine(j * offsetY,i * offsetX,j * offsetY + offsetY,i * offsetX);
                if(maze.hasWall(i,j, Maze.Direction.LEFT)) g.drawLine(j * offsetY,i * offsetX,j * offsetY,i * offsetX + offsetX);
                if(maze.hasWall(i,j, Maze.Direction.RIGHT)) g.drawLine(j * offsetY + offsetY,i * offsetX + offsetX,j * offsetY + offsetY,i * offsetX);
                if(maze.hasWall(i,j, Maze.Direction.DOWN)) g.drawLine(j * offsetY + offsetY,i * offsetX + offsetX,j * offsetY,i * offsetX + offsetX);
            }
        }
        g.setColor(Color.green);
        g.fillRect(0,0, offsetY, offsetX);
    }
    public void paintPlayer(Graphics g) {
        g.drawImage(player.getImg(), player.getY() * offsetY, player.getX() * offsetX, null);
    }

    class KeyClicked implements KeyListener {
        @Override
        public void keyTyped(KeyEvent keyEvent) {

        }

        @Override
        public void keyPressed(KeyEvent keyEvent) {
            int dx = 0, dy = 0;
            Maze.Direction dir = Maze.Direction.UP;
            int key = keyEvent.getKeyCode();
            switch (key){
                case KeyEvent.VK_UP:
                    dx = -1;
                    dir = Maze.Direction.UP;
                    break;
                case KeyEvent.VK_RIGHT:
                    dy = 1;
                    dir = Maze.Direction.RIGHT;
                    break;
                case KeyEvent.VK_DOWN:
                    dx = 1;
                    dir = Maze.Direction.DOWN;
                    break;
                case KeyEvent.VK_LEFT:
                    dy = -1;
                    dir = Maze.Direction.LEFT;
                    break;
            }
            if((dx != 0 || dy != 0) && canMove(dir)){
                player.move(dx, dy);
                repaint();
            }
        }

        @Override
        public void keyReleased(KeyEvent keyEvent) {
            if(finished()){
                System.out.println("You've won!");
                System.exit(0);
            }
        }
    }
}