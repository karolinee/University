#ifndef GAME_H
#define GAME_H


#include <ncurses.h>
#include <stdlib.h>
#include <time.h>

#include "level.h"
#include "actor.h"

typedef struct game{
    Level *level;
    Actor *player;
}Game;



Game *createGame();
void destroyGame(Game *game);
void renderGame(Game *game);
void drawHub(Game *game);

void gameEnd(Game *game);

void handleInput(Game *game,int input);

void newLevel(Game *game);

int canWalk(int y, int x, Game *game);
void gameFinish();

#endif