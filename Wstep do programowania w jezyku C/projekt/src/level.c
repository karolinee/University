#include "level.h"

/*create level*/
Level *createLevel(int depth)
{
    Level *newLevel = malloc(sizeof(Level));

    newLevel->depth = depth;
    newLevel->map = createMap(LINES - 4,COLS);
    newLevel->map->rooms = createRooms(newLevel);

    return newLevel;
}

Level *createLastLevel()
{
    Level *newLevel = malloc(sizeof(Level));

    newLevel->depth = 10;
    newLevel->map = createMap(LINES - 4,COLS);

    newLevel->map->rooms = createRooms(newLevel);

    /*
    selectMonsters(newLevel,newLevel->map->rooms[0]);*/

    return newLevel;
}

/*mking rooms*/
Room **createRooms(Level *level)
{
    Room **rooms = malloc(sizeof(struct room*)*9);

    for(int i = 0; i < 9 ; i++)
        rooms[i] = malloc(sizeof(struct room));     
    
    
    /*randomizing rooms*/
    if(level->depth!=10)
    {
        for(int i = 1; i < 8 ; i++)
        {
            int chance = rand() % 3; // 2/3 chance for the room to appear
            if(chance == 2) chance--;
            rooms[i]->isRoom = chance;
        }
        /*room 0 and 8 elways appear*/
        rooms[0]->isRoom = rooms[8]->isRoom = 1;
    }
    else
    {
        /*last level only has one room*/
        for(int i = 0; i < 9 ; i++)
        {
            rooms[i]->isRoom = 0;
        }
        rooms[1]->isRoom = 1;
    }
    

 
    if(level->depth<10)
    {
        for(int i = 0; i < 9 ; i++)
        {
            
            if(rooms[i]->isRoom == 1)
            {
                rooms[i]->height = rand()%((LINES-4)/3 - 4) + 3;
                rooms[i]->width = rand()%(COLS/3 - 5) + 5;

                rooms[i]->x = (COLS/3) * (i%3) + rand()%(COLS/3 - rooms[i]->width);
                if(rooms[i]->x == 1) rooms[i]->x = 0;
                

                rooms[i]->y = (LINES-4)/3 * (i/3) + rand()%((LINES-4)/3 - rooms[i]->height-1);
                if(rooms[i]->y == 1) rooms[i]->y = 0;
                if(rooms[i]->y + rooms[i]->height == LINES - 6) rooms[i]->height++;

                createRoom(level->map,rooms[i]->y,rooms[i]->x,rooms[i]->height,rooms[i]->width);
            }
            else
            {
                rooms[i]->x = 0;
                rooms[i]->y = 0;
                rooms[i]->width = 0;
                rooms[i]->height = 0;
                rooms[i]->numberOfMonsters = 0;
                rooms[i]->monsters = NULL;
            }
            
        }

  
        for(int i = 0 ; i < 9 ; i++)
        {
            if(rooms[i]->isRoom == 1)
            {
                if(i%3==0 || i%3 == 1)
                {
                    int x0 = rooms[i]->x + rooms[i]->width - 1 ;
                    int y0 = rand() % (rooms[i]->height - 2) + rooms[i]->y + 1;
                    level->map->tiles[y0][x0].canWalk =  DOOR;
                }

                if(i%3==2 || i%3 == 1)
                {
                    int x0 = rooms[i]->x;
                    int y0 = rand() % (rooms[i]->height - 2) + rooms[i]->y + 1;
                    level->map->tiles[y0][x0].canWalk = DOOR;
                }

                if(i/3==0 || i/3 == 1)
                {
                    int x0 = rand() % (rooms[i]->width - 2) + rooms[i]->x + 1;
                    int y0 = rooms[i]->y + rooms[i]->height;
                    level->map->tiles[y0][x0].canWalk = DOOR;
                 }

                if(i/3==2 || i/3 == 1)
                {
                    int x0 = rand() % (rooms[i]->width - 2) + rooms[i]->x + 1;
                    int y0 = rooms[i]->y;
                    level->map->tiles[y0][x0].canWalk = DOOR;
                }
            }
        }

    
      
        int x0 = rand() % (rooms[8]->width - 2) + rooms[8]->x + 1;
        int y0 = rand() % (rooms[8]->height - 2) + rooms[8]->y + 1;
        level->map->tiles[y0][x0].canWalk = STAIRS;

        
        for(int i = 1; i < 9 ; i++)
        {
            if(rooms[i]->isRoom == 1)
            {
                int ile = rand() % 3 + 1; //from 1 to 3 monsters
                level->map->numberOfMonsters += ile;
                rooms[i]->numberOfMonsters = ile;
                rooms[i]->monsters = malloc(sizeof(struct actor*)*ile);
                
                for(int j = 0 ; j < ile; j ++)
                    rooms[i]->monsters[j] = selectMonsters(level,rooms[i]); 
            }
            
        }
    }
    else
    {
        for(int i = 0 ; i < 9 ; i++)
        {
            rooms[i]->x = 0;
            rooms[i]->y = 0;
            rooms[i]->width = 0;
            rooms[i]->height = 0;
            rooms[i]->numberOfMonsters = 0;
            rooms[i]->monsters = NULL;
        }
        

        rooms[1]->height = LINES - 5;
        rooms[1]->width = COLS - 1;
        rooms[1]->x = 0;
        rooms[1]->y = 0;

        createRoom(level->map,0,0,LINES-5,COLS);

        int ile = 1;
        level->map->numberOfMonsters += ile;
        rooms[1]->numberOfMonsters = ile;
        rooms[1]->monsters = malloc(sizeof(Actor*)*ile);
        
        rooms[1]->monsters[0] = selectMonsters(level,rooms[1]);

    }

    return rooms;
}

/*choosing monster*/
Actor *selectMonsters(Level *level, Room *room)
{
    int monster;

    switch(level->depth)
    {
        case 1:
            monster = 0; //snake
            break;
        case 2:
            monster = rand()% 2; //snake, spider
            break;          
        case 3:
            monster = rand()% 3; //snake, spider, goblin
            break;
        case 4:
            monster = rand()% 2 + 1; //spider, goblin
            break;
        case 5:
            monster = rand()% 3 + 1; //spider, goblin,orc
            break;
        case 6:
            monster = rand()% 2 + 2; //goblin, orc
            break;
        case 7:
            monster = rand()% 3 + 2; //goblin, troll, orc
            break;
        case 8:
            monster = rand()% 3 + 2; //goblin, orc, troll
            break;
        case 9:
            monster = rand()% 2 + 3; //orc, troll
            break;
        case 10:
            monster = 5; //dragon
            break;      
    }
    
    
    /*positioning monster*/
    int x;
    int y;

    if(level->depth == 10)
    {
        x = COLS/2;
        y = (LINES-5)/2;
    }
    else
    {
        do
        {
            x = room->x;
            y = room->y;

            y += rand()% room->height;
            x += rand()% room->width;
        }while(level->map->tiles[y][x].canWalk!=FLOOR || level->map->tiles[y][x].occupied);
    }
    level->map->tiles[y][x].occupied = 1;
    
    /*creating monsters*/
    switch(monster)
    {
        case 0:
            return createActor(y,x,10,2,5,2,"SNAKE",'S');
            break;
        case 1:
            return createActor(y,x,15,3,8,4,"SPIDER",'X');
            break;
        case 2:
            return createActor(y,x,20,4,10,5,"GOBLIN",'G');
            break;
        case 3:
            return createActor(y,x,25,6,15,3,"ORC",'O');
            break;
        case 4:
            return createActor(y,x,30,8,20,5,"TROLL",'T');
            break;
        case 5:
            return createActor(y,x,50,10,100,10,"DRAGON",'D');
            break;
    }

    
    return createActor(y,x,15,1,1,1,"SNAKE",'S');
}

/*drawing whole level*/
void renderLevel(Level *level)
{
    renderMap(level->map);
}

/*moving all the monsters*/
void moveMonsters(Level *level)
{
    int shift;
    for(int i = 1 ; i <  9 ; i++)
    {
        /*checking if room is on the map*/
        if(level->map->rooms[i]->isRoom == 1 )
        {
            /*iterating throught monsters*/
            for(int j = 0; j < level->map->rooms[i]->numberOfMonsters;j++)
            {
                /*moving alive monsters*/
                if(level->map->rooms[i]->monsters[j]->alive == 1)
                {
                    shift = rand() % 4;

                    /*chcking if monster can move to that position*/
                    switch(shift)
                    {
                        case 0:
                            if(canWalkM(level->map->rooms[i]->monsters[j]->y+1,level->map->rooms[i]->monsters[j]->x,level->map)) 
                            {
                                level->map->tiles[level->map->rooms[i]->monsters[j]->y][level->map->rooms[i]->monsters[j]->x].occupied = 0;
                                level->map->tiles[level->map->rooms[i]->monsters[j]->y+1][level->map->rooms[i]->monsters[j]->x].occupied = 1;
                                level->map->rooms[i]->monsters[j]->y++;
                            }
                            break;
                        case 1:
                            if(canWalkM(level->map->rooms[i]->monsters[j]->y-1,level->map->rooms[i]->monsters[j]->x,level->map))
                            {
                                 level->map->tiles[level->map->rooms[i]->monsters[j]->y][level->map->rooms[i]->monsters[j]->x].occupied = 0;
                                 level->map->tiles[level->map->rooms[i]->monsters[j]->y-1][level->map->rooms[i]->monsters[j]->x].occupied = 1;
                                 level->map->rooms[i]->monsters[j]->y--;
                            }
                            break;
                        case 2:
                            if(canWalkM(level->map->rooms[i]->monsters[j]->y,level->map->rooms[i]->monsters[j]->x+1,level->map))
                            {
                                level->map->tiles[level->map->rooms[i]->monsters[j]->y][level->map->rooms[i]->monsters[j]->x].occupied = 0;
                                level->map->tiles[level->map->rooms[i]->monsters[j]->y][level->map->rooms[i]->monsters[j]->x+1].occupied = 1;
                                level->map->rooms[i]->monsters[j]->x++;
                            }
                            break;
                        case 3:
                            if(canWalkM(level->map->rooms[i]->monsters[j]->y,level->map->rooms[i]->monsters[j]->x-1,level->map))
                            {   
                                level->map->tiles[level->map->rooms[i]->monsters[j]->y][level->map->rooms[i]->monsters[j]->x].occupied = 0;
                                level->map->tiles[level->map->rooms[i]->monsters[j]->y][level->map->rooms[i]->monsters[j]->x-1].occupied = 1;
                                level->map->rooms[i]->monsters[j]->x--;
                            }   
                            break;
                        default:
                            break;
                    }
                }   
                else
                {
                    level->map->tiles[level->map->rooms[i]->monsters[j]->y][level->map->rooms[i]->monsters[j]->x].occupied = 0;
                }              
            }
        }
    }
}



void destroyLevel(Level *level)
{
    free(level->map->rooms[0]);
    for(int i = 1; i < 9 ; i++)
    {
        
            for(int j = 0; j < level->map->rooms[i]->numberOfMonsters ; j++)
            {
                free(level->map->rooms[i]->monsters[j]);
            }
            free(level->map->rooms[i]->monsters);
        

        free(level->map->rooms[i]);
        
    }

    free(level->map->rooms);
    
    
    for(int i = 0; i < level->map->height ; i++)
    {
        free(level->map->tiles[i]);
    }

    free(level->map->tiles);
    

    free(level->map);
    
    free(level);
    
}

