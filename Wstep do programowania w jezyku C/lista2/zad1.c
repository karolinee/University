#include <stdio.h>


int main(void)
{
    char znak;


    int litery[26]={0};


    while(znak != EOF)
    {
        znak = getchar();
        //int litera = tolower(znak)-'a';


        if(znak<'a' && litery[znak-'A']==0)
            litery[znak-'A']=1;



        if(znak<97)
        {
            if(litery[znak-65]%2)
                putchar(toupper(znak));
            else
                putchar(tolower(znak));

            litery[znak-65]++;
        }
        else
        {
            if(litery[znak-97]%2)
                putchar(toupper(znak));
            else
                putchar(tolower(znak));

            litery[znak-97]++;
        }


    }

    return 0;
}
