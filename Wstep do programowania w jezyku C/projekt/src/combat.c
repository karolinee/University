#include "combat.h"


void combat(Actor *player, Actor *monster)
{
    
    renderCombatScreen(player,monster,1);
    int ch = '\0';

    int run = 0;
    while(1)
    {

        int highlight = 1;
        renderCombatScreen(player,monster,highlight);
        int choice = 0;

		while(1)
        {
            ch = getch();

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
				    choice = highlight;
				    break;
                case KEY_F(1):
                    endwin();
                    exit(0);
                    break;
			    default:
				    break;
		    }
            
            renderCombatScreen(player,monster,highlight);
            if(choice!=0)
            {
                break;
            }
        }
        
    

        switch (choice)
        {
            case 1:
                attack(player,monster);
                break;
            case 2:
                healing(player);
                break;

            case 3:
                run = 1;
                break;

            default:
                break;
        }
        
        renderCombatScreen(player,monster,1);
        
        
        if(run)
            break;

    
        if(monster->health == 0)
        {
            monster->alive = 0;
            player->exp += monster->constitution;
            clear();
            if(monster->symbol != 'D')
            {
                mvprintw(LINES/2,(COLS-38)/2,"YOU DEFETED %s AND GAIND %d EXPERIENCE",monster->name,monster->constitution);
                mvprintw(LINES/2+1,(COLS-25)/2,"(press any key to continue)");
                getch();
            }
            
            break;
        }

        attack(monster,player);
    

        if(player->health == 0)
        {
            break;
        }
    }
}
  
void attack(Actor *attack, Actor *defend)
{
    int hit = rand() % 20 + 1;
    int damage = 0;

    if(hit == 1)
    {
        damage = 0;
    }
    else if(hit == 20 || hit + attack->dexterity >= rand()%20 + 1 + defend->dexterity)
    {
        damage = attack->strength + rand()%20 + 1;
    }

    defend->health -=damage;

    if(damage < 0) damage = 0;
    defend->health -= damage;

    if(defend->health < 0) defend->health = 0;

}

void healing(Actor *actor)
{
    actor->health += actor->constitution;

    if(actor->health > actor->maxHealth) actor->health = actor->maxHealth;
}


void renderCombatScreen(Actor *player, Actor *monster,int highlight)
{
    clear();

    attron(A_BOLD | COLOR_PAIR(5));
    mvprintw(1,(COLS-15)/2,"YOU FIGHT %s",monster->name);
    attroff(A_BOLD | COLOR_PAIR(5));

    attron(A_BOLD);
    mvprintw(4,3,"%s",player->name);
    attroff(A_BOLD);
    mvprintw(5,3,"Health %d(%d)",player->health,player->maxHealth);
    mvprintw(6,3,"Strength: %d",player->strength);
    mvprintw(7,3,"Dexterity: %d",player->dexterity);
    mvprintw(8,3,"Constitution: %d",player->constitution);

    attron(A_BOLD);
    mvprintw(4,COLS - 3 - 15,monster->name);
    attroff(A_BOLD);
    mvprintw(5,COLS - 3 - 15,"Health %d(%d)",monster->health,monster->maxHealth);
    mvprintw(6,COLS - 3 - 15,"Strength: %d",monster->strength);
    mvprintw(7,COLS - 3 - 15,"Dexterity: %d",monster->dexterity);
    mvprintw(8,COLS - 3 - 15,"Constitution: %d",monster->constitution);
    


    char *choices[] = { 
			"Attack",
			"Heal",
			"Run"
		  };
    
    attron(A_BOLD | COLOR_PAIR(5));
    mvprintw(LINES/2,(COLS-29)/2,"Choose action and press enter");
    attroff(A_BOLD | COLOR_PAIR(5));
    
    for(int i = 0; i < 3; i++)
	{	
        
        if(highlight == i + 1) 
		{	
            attron(A_REVERSE); 
			mvprintw(LINES/2+1+i, (COLS-strlen(choices[i]))/2, "%s", choices[i]);
			attroff(A_REVERSE);
		}
		else
			mvprintw(LINES/2+1+i, (COLS-strlen(choices[i]))/2, "%s", choices[i]);
	}   


}