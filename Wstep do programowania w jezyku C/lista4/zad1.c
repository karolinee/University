#include <stdio.h>


int main(void)
{

    int c;
    int dlu=1, max_dlu = 1;

    int akt;
    int pop = 2;

    /*c=getchar();
    pop = (c & 128);

    do{

        akt = ( c & 128 );
        if(pop != 2 && pop != akt)
            dlu++;
        else
        {
            max_dlu = dlu;
            dlu=1;
        }
        pop = akt;
        c<<=1;


    }while(c!='\n')*/



    while((c=getchar())!='\n')
    {

        for(int i = 0 ; i < 8 ; i++ )
        {
            akt = ( c & 128 );
            if(pop != 2 && pop != akt)
                dlu++;
            else
            {
                if(max_dlu<dlu)
                    max_dlu = dlu;
                dlu=1;
            }

            pop = akt;
            c<<=1;
        }

    }

    if(max_dlu < dlu)
        printf("%d", dlu);
    else
        printf("%d", max_dlu);





    return 0;

}


