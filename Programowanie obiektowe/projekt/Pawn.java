import java.awt.*;

public class Pawn {
    private Color color; //color pionka
    private int x; //pozycja x pionka na plaszy
    private int y; //pozycja y pionka na planszy
    private int pathPlace; //pozycja pionka pa ścieżce
    private int[][] path; //ścieżka
    private int[][] home; //baza

    public Pawn(Color color)
    {
        this.color = color;

        if(color == Color.RED)
        {

            path = new int[][]{
                    {4, 0}, {4, 1}, {4, 2}, {4, 3}, {4, 4},
                    {3, 4}, {2, 4}, {1, 4}, {0, 4},
                    {0, 5}, {0, 6},
                    {1, 6}, {2, 6}, {3, 6}, {4, 6},
                    {4, 7}, {4, 8}, {4, 9}, {4, 10},
                    {5, 10}, {6, 10},
                    {6, 9}, {6, 8}, {6, 7}, {6, 6},
                    {7, 6}, {8, 6}, {9, 6}, {10, 6},
                    {10, 5}, {10, 4},
                    {9, 4}, {8, 4}, {7, 4}, {6, 4},
                    {6, 3}, {6, 2}, {6, 1}, {6, 0},
                    {5, 0},
                    {5, 1}, {5, 2}, {5, 3}, {5, 4},
                    {5, 5}};
            home = new int[][]{
                    {0, 0}, {0, 1}, {1, 0}, {1, 1}};
        }
        else if(color == Color.YELLOW)
        {
            path = new int[][]{
                    {0, 6}, {1, 6}, {2, 6}, {3, 6}, {4, 6},
                    {4, 7}, {4, 8}, {4, 9}, {4, 10},
                    {5, 10}, {6, 10},
                    {6, 9}, {6, 8}, {6, 7}, {6, 6},
                    {7, 6}, {8, 6}, {9, 6}, {10, 6},
                    {10, 5}, {10, 4},
                    {9, 4}, {8, 4}, {7, 4}, {6, 4},
                    {6, 3}, {6, 2}, {6, 1}, {6, 0},
                    {5, 0}, {4, 0},
                    {4, 1}, {4, 2}, {4, 3}, {4, 4},
                    {3, 4}, {2, 4}, {1, 4}, {0, 4},
                    {0, 5},
                    {1, 5}, {2, 5}, {3, 5}, {4, 5},
                    {5, 5}};
            home = new int[][]{
                    {0, 9}, {0, 10}, {1, 9}, {1, 10}};
        }
        else if(color == Color.GREEN)
        {
            path = new int[][]{
                    {6, 10}, {6, 9}, {6, 8}, {6, 7}, {6, 6},
                    {7, 6}, {8, 6}, {9, 6}, {10, 6},
                    {10, 5}, {10, 4},
                    {9, 4}, {8, 4}, {7, 4}, {6, 4},
                    {6, 3}, {6, 2}, {6, 1}, {6, 0},
                    {5, 0}, {4, 0},
                    {4, 1}, {4, 2}, {4, 3}, {4, 4},
                    {3, 4}, {2, 4}, {1, 4}, {0, 4},
                    {0, 5},{0, 6},
                    {1, 6}, {2, 6}, {3, 6}, {4, 6},
                    {4, 7}, {4, 8}, {4, 9}, {4, 10},
                    {5, 10},
                    {5, 9}, {5, 8}, {5, 7}, {5, 6},
                    {5, 5}};
            home = new int[][]{
                    {9, 9}, {9, 10}, {10, 9}, {10, 10}};
        }
        else
        {
            path = new int[][]{
                    {10, 4}, {9, 4}, {8, 4}, {7, 4}, {6, 4},
                    {6, 3}, {6, 2}, {6, 1}, {6, 0},
                    {5, 0}, {4, 0},
                    {4, 1}, {4, 2}, {4, 3}, {4, 4},
                    {3, 4}, {2, 4}, {1, 4}, {0, 4},
                    {0, 5},{0, 6},
                    {1, 6}, {2, 6}, {3, 6}, {4, 6},
                    {4, 7}, {4, 8}, {4, 9}, {4, 10},
                    {5, 10}, {6, 10},
                    {6, 9}, {6, 8}, {6, 7}, {6, 6},
                    {7, 6}, {8, 6}, {9, 6}, {10, 6},
                    {10, 5},
                    {9, 5}, {8, 5}, {7, 5}, {6, 5},
                    {5, 5}};
            home = new int[][]{
                    {9, 0}, {9, 1}, {10, 0}, {10, 1}};
        }
    }

    //settery i gettery róznych zmiennych
    public Color getColor()
    {
        return color;
    }

    public void setX(int x)
    {
        this.x = x;
    }

    public void setY(int y)
    {
        this.y = y;
    }

    public int getX()
    {
        return x;
    }

    public int getY()
    {
        return y;
    }

    public int getPathPlace()
    {
        return pathPlace;
    }

    public void setPathPlace(int pathPlace)
    {
        this.pathPlace = pathPlace;
    }

    public int[][] getPath()
    {
        return path;
    }

    public int[][] getHome()
    {
        return home;
    }

    public boolean finish() //sprawdzanie czy pionek jest na mecie
    {
        return (x == 5 && y == 5);
    }
}
