#ifndef COMBAT_H
#define COMBAT_H


#include <ncurses.h>
#include <stdlib.h>
#include <time.h>





#include "map.h"
#include "actor.h"

void combat(Actor *player, Actor *monster);

int playerRound();
void renderCombatScreen(Actor *player, Actor *monster,int highlight);


void attack(Actor *attack, Actor *defend);
void healing(Actor *actor);

#endif

