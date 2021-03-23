#include "map.h"

/*creating map*/
Map *createMap(int height, int width)
{
    Map *newMap = malloc(sizeof(Map));

    newMap->height = height;
    newMap->width = width;


    newMap->tiles = malloc(sizeof(Tile*)*height);


    newMap->numberOfMonsters = 0;

    for(int i = 0; i < height; i++)
    {
        newMap->tiles[i] = malloc(sizeof(Tile)*width);
  
    
    }

    setTiles(newMap);

    return newMap;
}

/*making frame and floor*/
void setTiles(Map *map)
{
    for(int y = 0; y < map->height; y++)
        for(int x = 0 ; x < map->width ; x++)
        {
            if(y==0 || x == 0  || x == map->width - 1  || y == map->height - 1)
                map->tiles[y][x].canWalk = WALL;
        
            else
                map->tiles[y][x].canWalk = FLOOR;

            map->tiles[y][x].occupied = 0;
        }
}




/*making single room*/
void createRoom(Map *map,int y,int x,int height,int width)
{
    for(int y1 = y+1; y1 < height + y ; y1++)
    {
        map->tiles[y1][x].canWalk = WALL;
        map->tiles[y1][x+width-1].canWalk = WALL;
    }

    for(int x1 = x ; x1 < width + x; x1++)
    {
        map->tiles[y][x1].canWalk = WALL;
        map->tiles[y+height][x1].canWalk = WALL;
    }
}


/*checking if position is wall*/
int isWall(int y,int x, Map *map)
{
    if(map->tiles[y][x].canWalk==WALL)
        return 1;

    return 0;
}

/*checking if position is door*/
int isDoor(int y, int x,Map *map)
{
    if(map->tiles[y][x].canWalk==DOOR)
        return 1;

    return 0;
}

/*checking if monster can move to position*/
int canWalkM(int y, int x, Map *map)
{
    if(isWall(y,x,map))
        return 0;

    if(isDoor(y,x,map))
        return 0;

    if(map->tiles[y][x].occupied == 1)
        return 0;
    
    return 1;
}

/*checking if player is in the room - POV*/
int inRoom(Actor *player, Room *room)
{
    for(int i = room->y ; i <= room->y + room->height;i++)
        for(int j = room->x ; j < room->x + room->width ; j++)
        {
            if(i==player->y && j==player->x)    return 1;
        }
    return 0;
}

/*drawing map*/
void renderMap(Map *map)
{
    for(int y = 0; y < map->height; y++)
        for(int x = 0 ; x < map->width ; x++)
        {
            if(map->tiles[y][x].canWalk == WALL) mvaddch(y,x,'#');
            if(map->tiles[y][x].canWalk == DOOR) mvaddch(y,x,'+');
            
            if(map->numberOfMonsters == 0)
            {
                attron(A_BLINK);
                if(map->tiles[y][x].canWalk == STAIRS) mvaddch(y,x,'>');
                attroff(A_BLINK);
            }
            else
            {
                if(map->tiles[y][x].canWalk == STAIRS) mvaddch(y,x,'>');
            }  
        }
}