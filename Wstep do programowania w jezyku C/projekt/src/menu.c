#include "menu.h"

/*main menu loop*/
void mainMenu()
{
    int choice = menu();

    switch(choice)
    {
        case 1:
            break;
        case 2:
            printInstructions();
            mainMenu();
            break;
        case 3:
            endwin();
            exit(0);
            break;
    }
}

/*menu choice loop*/
int menu()
{
    int highlight = 1;

    while(1)
    {
        printMenu(highlight);
        int ch = getch();

        switch(ch)
		{	
            case KEY_UP:
            case 'w':
            case 'W':
				if(highlight == 1)
					highlight = 3;
				else
					--highlight;
				break;
			case KEY_DOWN:
            case 's':
            case 'S':
				if(highlight == 3)
				    highlight = 1;
				else 
				    ++highlight;
				break;
			case 10:
				return highlight;
				break;
            case KEY_F(1):
                endwin();
                exit(0);
                break;
			default:
				break;
		}
    }
}


/*printing menu options*/
void printMenu(int i)
{
    clear();
    
    char *menu[] = {
      "Start",
      "Instructions",
      "Exit"};

    for(int j = 0; j < 3; j++)
	{	
        if(i == j + 1) 
		{	
            attron(A_REVERSE); 
		    mvprintw(LINES/2+j, (COLS-strlen(menu[j]))/2, "%s", menu[j]);
			attroff(A_REVERSE);
		} 
		else
			mvprintw(LINES/2+j, (COLS-strlen(menu[j]))/2, "%s", menu[j]);
	}
}

/*instruction screen*/
void printInstructions()
{
    clear();
    mvaddch(1,3,'@' | A_REVERSE);
    mvprintw(1,5,"is your character.\n");
    printw("   To move your character use wsad or/and arrow keys.\n");
    printw("   Kill all monsters on the level to be able to go to the next.\n");
    printw("   To go to the next level step on \">\".\n");
    printw("   To win the game, reach 10th level and kill the last monster.\n");
    printw("   If you gain 100 exp you can expand your abilities.\n");
    printw("   During the game press F1 to exit.");

    mvprintw(LINES-1,3,"Press any key to come back to main menu");
    int ch = getch();

    if(ch == KEY_F(1))
    {
        endwin();
        exit(0);
    }
}