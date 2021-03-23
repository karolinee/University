#ifndef MAP_H
#define MAP_H


#include <ncurses.h>
#include <stdlib.h>
#include <time.h>


#include "actor.h"
#include "combat.h"

enum type{FLOOR,WALL,DOOR,STAIRS};

typedef struct room{
    int width, height;
    int x, y;
    int isRoom;
    Actor **monsters;
    int numberOfMonsters;
}Room;

typedef struct tile{
    int canWalk;
    int occupied;
}Tile;

typedef struct map{
    int width, height;
    Room **rooms;
    Tile **tiles;
    int numberOfMonsters;
}Map;



Map *createMap(int height, int width);
void setTiles(Map *map);
void renderMap(Map *map);

void createRoom(Map *map,int y,int x,int height,int width);

int canWalkM(int y, int x, Map *map);

int isWall(int y,int x, Map *map);

int isDoor(int y, int x,Map *map);
int inRoom(Actor *player, Room *room);

#endif

