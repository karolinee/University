#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>

#define MAX 5

/*
4 5
aaaa
bbbb
ccaa
dddd
eecc */

int height = MAX , width = MAX;
int min_movements;
int number_of_colours;
char board[MAX][MAX];
bool used_char[126];
int colours[2*MAX];

void floodit(int p,int q,int newc);
bool monochrome(void);
void colour_order(int counter);

int main(void)
{
    scanf("%d%d",&height,&width);

    min_movements = height * width;

    for(int i = 0 ; i < height ; i++)
        for(int j = 0 ; j < width ; j++)
        {
            scanf(" %c",&board[i][j]);
            int pom = board[i][j];
            used_char[pom] = 1;
        }

    for(int i = 0 ; i < 126 ; i++)
        if(used_char[i]) number_of_colours++;

    int k = 0;

    for(int i = 0 ; i < 126 ; i++)
        if(used_char[i]) colours[k++]=i;

    colour_order(1);

    printf("%d",min_movements);

    return 0;

}
bool monochrome(void)
{
    char base = board[0][0];

    for(int i = 0 ; i < height ; i++)
        for(int j = 0 ; j < width ; j++)
            if(board[i][j]!=base) return false;

    return true;
}
void floodit(int p,int q,int new_colour)
{
    char prev_colour  = board[p][q];

    if(prev_colour == new_colour)
        return;

    board[p][q] = new_colour;

    if(q-1 >= 0 && board[p][q-1]==prev_colour)
    floodit(p,q-1,new_colour);

    if(q+1 < width && board[p][q+1]==prev_colour)
    floodit(p,q+1,new_colour);

    if(p-1 >= 0 && board[p-1][q]==prev_colour)
    floodit(p-1,q,new_colour);

    if(p+1 < height && board[p+1][q]==prev_colour)
    floodit(p+1,q,new_colour);
}
void colour_order(int counter)
{
    if(counter == height * width)
        return;


    char tmp[height][width];

    for(int i = 0 ; i < height ; i++)
        for(int j = 0 ; j < width ; j++)
            tmp[i][j]=board[i][j];


    for(int i = 0 ; i < height ; i++)
        for(int j = 0 ; j < width ; j++)
            for(int l = 0 ; l < number_of_colours ; l++)
            {

                floodit(i,j,colours[l]);

                if(monochrome())
                {
                    if(counter < min_movements) min_movements = counter;
                }
                else
                    colour_order(counter+1);

                for(int a = 0 ; a < height ; a++)
                    for(int b = 0 ; b < width ; b++)
                        board[a][b]=tmp[a][b];

            }


}






