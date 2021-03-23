#ifndef ACTOR_H
#define ACTOR_H

#include <ncurses.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

//#include "map.h"

typedef struct actor{
    int x,y;
    int symbol;
    int color;
    int health;
    int maxHealth;
    int exp;
    int alive;
    int strength;
    int constitution;
    int dexterity;
    char name[30];
}Actor;

Actor *createActor(int y, int x, int maxHealth,int str, int con, int dex, char *name,int symbol);
void renderActor(Actor *actor);

void placePlayer(Actor *player, int y, int x);

Actor *characterCreation();

void printClassScreen(int highlight);
int classScreen();

void playerNextLevel(Actor *player);
void printChoiceScreen(int highlight,Actor *player);

#endif