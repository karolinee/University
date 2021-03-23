import javax.imageio.ImageIO;
import java.awt.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.Random;

public class Player {
    private int x, y;
    Image img;

    public Player(int maxX, int maxY) {
        Random rand = new Random();
        this.x = rand.nextInt(maxX);
        this.y = rand.nextInt(maxY);

        if(x == 0 && y == 0) x = maxX - 1;


        try{
            InputStream path = this.getClass().getResourceAsStream("player_img.png");
            img = ImageIO.read(path);
        }
        catch (IOException e){
            e.printStackTrace();
            System.out.println("cant find image file");
        }

    }

    public void move(int dx, int dy) {
        x += dx;
        y += dy;
    }

    public int getX(){
        return x;
    }

    public int getY(){
        return y;
    }

    public Image getImg(){
        return img;
    }
}