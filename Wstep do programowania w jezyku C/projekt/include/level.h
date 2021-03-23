#ifndef LEVEL_H
#define LEVEL_H


#include <ncurses.h>
#include <stdlib.h>
#include <time.h>

#include "map.h"
#include "actor.h"

typedef struct level{
    int depth;
    Map *map;
}Level;

Level *createLevel(int depth);

Room **createRooms(Level *level);

Actor *selectMonsters(Level *level, Room *room);

void renderLevel(Level *level);

void moveMonsters(Level *level);
void destroyLevel(Level *level);

Level *createLastLevel();


#endif