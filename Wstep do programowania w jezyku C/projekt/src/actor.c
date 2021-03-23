#include "actor.h"

/*create actor*/
Actor *createActor(int y, int x, int maxHealth, int str, int con, int dex, char name[30],int symbol)
{
    Actor *newActor = malloc(sizeof(struct actor));

    newActor->y = y;
    newActor->x = x;

    newActor->symbol = symbol;

    newActor->maxHealth = maxHealth;
    newActor->health = maxHealth;

    newActor->exp = 0;

    newActor->alive = 1;

    newActor->strength = str;
    newActor->constitution = con;
    newActor->dexterity = dex;
    
    strcpy(newActor->name,name);

    switch(symbol)
    {
        case '@':
            newActor->color = 4;
            break;
        case 'S':
            newActor->color = 3;
            break;
        case 'X':
            newActor->color = 7;
            break;  
        case 'G':
            newActor->color = 4;
            break; 
        case 'T':
            newActor->color = 6;
            break; 
        case 'O':
            newActor->color = 5;
            break; 
        case 'D':
            newActor->color = 1;
            break;   
        default:
            newActor->color = 3;
    }

    return newActor;
}

/*putting player in position x y*/
void placePlayer(Actor *player, int y, int x)
{
    player->x = x;
    player->y = y;
}

/*drawing actors*/
void renderActor(Actor *actor)
{
    attron(COLOR_PAIR(actor->color));
    if(actor->symbol == '@')
        mvaddch(actor->y,actor->x,actor->symbol | A_REVERSE);
    else
        mvaddch(actor->y,actor->x,actor->symbol);  
    attroff(COLOR_PAIR(actor->color));
}



/*making player character*/
Actor *characterCreation()
{
    int class = classScreen();

    /*choosing character name*/
    clear();
    char imie[30];
    echo();
    attron(A_BOLD | COLOR_PAIR(5)); 
    mvprintw(LINES/2-1,(COLS-19)/2,"Name your character");
    attroff(A_BOLD | COLOR_PAIR(5)); 
    move(LINES/2+1,(COLS-19)/2);
    scanw("%s",imie);
    noecho();
    
    /*making character*/
    switch(class)
    {
        case 1:
            return createActor(0,0,1000,6,4,3,imie,'@');
            break;
        case 2:
            return createActor(0,0,1000,3,4,6,imie,'@');
            break;
    }

    return createActor(0,0,1000,6,4,3,imie,'@');
}

/*class choice loop*/
int classScreen()
{
    int highlight = 1;

    while(1)
    {
        printClassScreen(highlight);
        int ch = getch();

        switch(ch)
		{	
            case KEY_UP:
            case 'w':
            case 'W':
				if(highlight == 1)
					highlight = 2;
				else
					--highlight;
				break;
			case KEY_DOWN:
            case 's':
            case 'S':
				if(highlight == 2)
				    highlight = 1;
				else 
				    ++highlight;
				break;
			case 10:
				return highlight;
				break;
		    default:
				break;
		}
    }
}

/*printing class screen*/
void printClassScreen(int highlight)
{
    clear();
    char *class[] = {
        "Warrior",
        "Rogue",
    };
    
    attron(A_BOLD | COLOR_PAIR(5)); 
    mvprintw(LINES/2-1, (COLS-17)/2, "Choose your class");
    attroff(A_BOLD | COLOR_PAIR(5));

    for(int i = 0 ; i < 2 ; i++)
    {
        if(highlight == i + 1) 
		{	
            attron(A_REVERSE); 
		    mvprintw(LINES/2+i, (COLS-strlen(class[i]))/2, "%s",class[i]);
			attroff(A_REVERSE);
		} 
		else
		{
            mvprintw(LINES/2+i, (COLS-strlen(class[i]))/2, "%s",class[i]);
        }  
    }

    if(highlight == 1)
    {
        mvprintw(LINES/2+5, (COLS-53)/2, "High strength, moderate constitution, low dexterity.");
        mvprintw(LINES/2+6, (COLS-68)/2, "Deals a lot of damage, but chance of hitting the target are smaller.");
    }

    if(highlight == 2)
    {
        mvprintw(LINES/2+5, (COLS-53)/2, "High dexterity, moderate constitution, low strength.");
        mvprintw(LINES/2+6, (COLS-61)/2, "Chance of hitting the target are great, but deals less damage.");
    }
}

/*player getting to the next level*/
void playerNextLevel(Actor *player)
{
    int choice = 0;
    int highlight = 1;
    /*next level improv choice loop*/
    while(1)
    {
        printChoiceScreen(highlight,player);
        int ch = getch();

        switch(ch)
		{	
            case KEY_UP:
            case 'w':
            case 'W':
				if(highlight == 1)
					highlight = 4;
				else
					--highlight;
			    break;
			case KEY_DOWN:
            case 's':
            case 'S':
				if(highlight == 4)
				    highlight = 1;
				else 
				    ++highlight;
				break;
			case 10:
				choice = highlight;
				break;
            case KEY_F(1):
              endwin();
              exit(0);
              break;
		    default:
				break;
		  }
        
        if(choice!=0)
            break;
    }

    switch(choice)
    {
        case 1:
            player->strength++;
            break;
        case 2:
            player->dexterity++;
            break;
        case 3:
            player->constitution++;
            break;
        case 4:
            player->maxHealth+=5;
            break;
        default:
            break;
    }

    player->health = player->maxHealth;
    player->exp -= 100;


}

/*printing choice screen*/
void printChoiceScreen(int highlight,Actor *player)
{
    clear();
    char *choice[] = {
        "Strength",
        "Dexterity",
        "Constitution",
        "Health"
    };
    
    attron(A_BOLD | COLOR_PAIR(5)); 
    mvprintw(LINES/2-1,(COLS-31)/2, "Choose what you want to improve");
    attroff(A_BOLD | COLOR_PAIR(5));

    for(int i = 0 ; i < 4 ; i++)
    {
        
        if(highlight == i + 1) 
		{	
            attron(A_REVERSE); 
		    mvprintw(LINES/2+i, (COLS-strlen(choice[i]))/2, "%s",choice[i]);
			attroff(A_REVERSE);
		} 
		else
			mvprintw(LINES/2+i, (COLS-strlen(choice[i]))/2, "%s",choice[i]);
	  
    }

    if(highlight == 1)
    {
        mvprintw(LINES/2+5, (COLS-64)/2, "Your current strength = %d, your strenght after improvement = %d",player->strength,player->strength+1);
    }

    if(highlight == 2)
    {
        mvprintw(LINES/2+5, (COLS-66)/2, "Your current dexterity = %d, your dexterity after improvement = %d",player->dexterity,player->dexterity+1);
    }

    if(highlight == 3)
    {
       mvprintw(LINES/2+5, (COLS-72)/2, "Your current constitution = %d, your constitution after improvement = %d",player->constitution,player->constitution+1);
    }

    if(highlight == 4)
    {
       mvprintw(LINES/2+5, (COLS-68)/2, "Your current max health = %d, your max health after improvement = %d",player->maxHealth,player->maxHealth+5);
    }
}