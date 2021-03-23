import java.util.*;

public class Maze {
    public enum Direction{
        UP,
        LEFT,
        DOWN,
        RIGHT
    }
    int width;
    int height;
    Cell[][] grid;

    public Maze(int height, int width){
        this.height = height;
        this.width = width;
        grid = new Cell[height][width];
        for(int i  = 0 ; i < height; i++){
            for(int j = 0; j < width; j++){
                grid[i][j] = new Cell();
            }
        }
        createMaze();
    }
    public void createMaze(){
        List<Wall> walls = new ArrayList<>();
        DSet[][] sets = new DSet[height][width];
        for(int i  = 0 ; i < height; i++){
            for(int j = 0; j < width; j++){
                if(j > 0) walls.add(new Wall(i,j, Direction.LEFT));
                if(i > 0) walls.add(new Wall(i,j, Direction.UP));
                sets[i][j] = new DSet();
            }
        }

        Collections.shuffle(walls);

        while(!walls.isEmpty()){
            Wall wall = walls.remove(0);
            int x = wall.getX();
            int y = wall.getY();
            Direction dir = wall.getDir();
            int nx = x;
            int ny = y;
            switch (dir){
                case LEFT:
                    ny-=1;
                    break;
                case UP:
                    nx-=1;
                    break;
            }

            if(!sets[x][y].isConnected(sets[nx][ny])){
                sets[x][y].connect(sets[nx][ny]);
                grid[x][y].removeWall(dir);
                grid[nx][ny].removeWall(opposite(dir));
            }
        }

    }
    public boolean hasWall(int i, int j, Direction dir){
        return grid[i][j].hasWall(dir);
    }

    public Direction opposite(Direction dir){
        switch (dir){
            case LEFT:
                return Direction.RIGHT;
            case UP:
                return Direction.DOWN;
            case DOWN:
                return Direction.UP;
            case RIGHT:
                return Direction.LEFT;
        }
        throw new IllegalArgumentException("wrong direction");
    }

    private class Cell {
        Map<Direction, Boolean> walls;
        public Cell(){
            walls = new EnumMap<>(Direction.class);
            walls.put(Direction.UP, true);
            walls.put(Direction.LEFT, true);
            walls.put(Direction.DOWN, true);
            walls.put(Direction.RIGHT, true);
        }
        public boolean hasWall(Direction dir){
            return walls.get(dir);
        }
        public void removeWall(Direction dir){
            walls.put(dir, false);
        }
    }
    private class Wall {
        final int x, y;
        final Direction dir;
        public Wall(int x, int y, Direction dir){
            this.x = x;
            this.y = y;
            this.dir = dir;
        }
        public int getX(){
            return x;
        }
        public int getY(){
            return y;
        }
        public Direction getDir(){
            return dir;
        }
    }
    private class DSet {
        DSet parent = null;
        public DSet root(){
            if(parent == null) return this;
            return parent.root();
        }
        public boolean isConnected(DSet s){
            return this.root() == s.root();
        }
        public void connect(DSet s){
            s.root().parent = this;
        }
    }
}