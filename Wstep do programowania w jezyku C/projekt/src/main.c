#include <stdlib.h>
#include <ncurses.h>
#include <time.h>
#include "map.h"
#include "actor.h"
#include "level.h"
#include "menu.h"
#include "game.h"

void screenInit();

int main()
{
	screenInit();
  mainMenu();

  Game *game = createGame();

  
  int ch = '\0';
  
  /*main game loop*/
  while(ch!=KEY_F(1))
  {   
      if(game->player->exp >= 100)
          playerNextLevel(game->player);

      renderGame(game);
      moveMonsters(game->level);     
      ch = getch();
      handleInput(game,ch);    
  }


  destroyGame(game);
	endwin();
	return 0;
}

void screenInit()
{
	  initscr();
    noecho();
  	cbreak();
  	curs_set(0);
  	start_color();
    use_default_colors();
    start_color();
    
    init_pair(8, COLOR_BLACK, -1);
    init_pair(1, COLOR_RED, -1);
    init_pair(2, COLOR_GREEN, -1);
    init_pair(3, COLOR_YELLOW, -1);
    init_pair(4, COLOR_BLUE, -1);
    init_pair(5, COLOR_MAGENTA, -1);
    init_pair(6, COLOR_CYAN, -1);
    init_pair(7, COLOR_WHITE, -1);

  	srand(time(NULL));	

  	keypad(stdscr, TRUE);

    refresh();
}

