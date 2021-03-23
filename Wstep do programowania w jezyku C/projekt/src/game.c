#include "game.h"

/*create game function*/
Game *createGame()
{
    Game *game = malloc(sizeof(struct game));

    game->level = createLevel(1);

    game->player = characterCreation();
    placePlayer(game->player,game->level->map->rooms[0]->y+1,game->level->map->rooms[0]->x+1);

    return game;
}

void destroyGame(Game *game)
{
    destroyLevel(game->level);
    free(game->player);
    free(game);
}

/*drawing whole game screen*/
void renderGame(Game *game)
{
    clear();
    renderLevel(game->level);
    
    drawHub(game);

    renderActor(game->player);

    for(int i = 1 ; i < 9 ; i ++)
    {
        if(game->level->map->rooms[i]->isRoom == 1 && inRoom(game->player,game->level->map->rooms[i]))
        {
            for(int j = 0 ; j < game->level->map->rooms[i]->numberOfMonsters;j++)
            {
                if(game->level->map->rooms[i]->monsters[j]->alive == 1)
                    renderActor(game->level->map->rooms[i]->monsters[j]);
            }
        }
    }
}

/*drawing game hub*/
void drawHub(Game *game)
{
    mvprintw(LINES - 3, 0, "   Depth: %d", game->level->depth);
    printw("   Hp: %d(%d)", game->player->health, game->player->maxHealth);
    printw("   Str: %d", game->player->strength);
    printw("   Con: %d", game->player->constitution);
    printw("   Dex: %d", game->player->dexterity);
    printw("   Exp: %d", game->player->exp);

    mvprintw(LINES - 2, 0, "   monsters %d", game->level->map->numberOfMonsters);

}

/*handle input */
void handleInput(Game *game,int input)
{
    switch(input)
    {
        case 'w':
        case 'W':
        case KEY_UP:
            if(canWalk(game->player->y-1,game->player->x,game))
            {
                game->level->map->tiles[game->player->y][game->player->x].occupied=0;
                game->level->map->tiles[game->player->y-1][game->player->x].occupied=1;
                game->player->y--;
            }
            break;
        case 's':
        case 'S':
        case KEY_DOWN:
            if(canWalk(game->player->y+1,game->player->x,game))
            {
                game->level->map->tiles[game->player->y][game->player->x].occupied=0;
                game->level->map->tiles[game->player->y+1][game->player->x].occupied=1;
                game->player->y++;
            }
            break;
        case 'a':
        case 'A':
        case KEY_LEFT:
            if(canWalk(game->player->y,game->player->x-1,game))
            {
                game->level->map->tiles[game->player->y][game->player->x].occupied=0;
                game->level->map->tiles[game->player->y][game->player->x-1].occupied=1;
                game->player->x--;
            }
            break;
        case 'd':
        case 'D':
        case KEY_RIGHT:
            if(canWalk(game->player->y,game->player->x+1,game))
            {
                game->level->map->tiles[game->player->y][game->player->x].occupied=0;
                game->level->map->tiles[game->player->y][game->player->x+1].occupied=1;
                game->player->x++;
            }
            break;
        default:
            break;
        }
}

/*checking if player can move to position*/
int canWalk(int y, int x, Game *game)
{
    /*can player go to the next level?*/
    if(game->level->map->tiles[y][x].canWalk==STAIRS && game->level->map->numberOfMonsters  == 0)
    {
        newLevel(game);
        return 0;
    }
    
    /*is it wall?*/
    if(isWall(y,x,game->level->map))
        return 0;

    /*is it monster?*/
    if(game->level->map->tiles[y][x].occupied == 1)
    {
        Actor *monster = NULL;
        for(int i = 1; i < 9; i++)
        {
            if(game->level->map->rooms[i]->isRoom == 1 && inRoom(game->player, game->level->map->rooms[i]))
            {
                for(int j = 0 ; j < game->level->map->rooms[i]->numberOfMonsters; j++)
                {
                    if((game->level->map->rooms[i]->monsters[j]->alive == 1) && (game->level->map->rooms[i]->monsters[j]->y == y) && (game->level->map->rooms[i]->monsters[j]->x == x))
                        monster = game->level->map->rooms[i]->monsters[j];

                    game->level->map->tiles[y][x].occupied = 0;
                }
            }
        }
        
        if(monster!=NULL)
            combat(game->player,monster);

        if(game->player->health == 0)
            gameEnd(game);

        
        if(monster!=NULL && monster->alive == 0)
            game->level->map->numberOfMonsters--;
        
    
        if(game->level->depth == 10 && monster->alive == 0)
            gameFinish(game); 
    }

    return 1;
}

/*making next level*/
void newLevel(Game *game)
{ 
    int depth = game->level->depth + 1;
    
     destroyLevel(game->level);

    if(depth!=10)
    {
        game->level = createLevel(depth);
        placePlayer(game->player,game->level->map->rooms[0]->y+1,game->level->map->rooms[0]->x+1);
    }
    else
    {
        game->level = createLastLevel();
        placePlayer(game->player,2,2);
    } 

    
    
}

void gameFinish(Game *game)
{
    clear();
    mvprintw(LINES/2,(COLS -26 )/2,"YOU WON. CONGRATULATIONS!");
    getch();
    destroyGame(game);
    endwin();
    exit(0);
}

void gameEnd(Game *game)
{
    clear();
    mvprintw((LINES-1)/2,(COLS - 22)/2,"YOU HAVE BEEN DEFEATED");
    mvprintw((LINES-1)/2 + 2,(COLS - 15)/2,"END OF THE GAME");
    destroyGame(game);
    getch();
    endwin();
    exit(0);
}