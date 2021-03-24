#include <stdio.h>

int main(void)
{
    int i=0;


    int c;

    static int ost[10000];




    while((c=getchar())!=EOF)
    {

        if(c=='(' || c==')' || c=='{' || c=='}' || c=='[' || c==']' )
        {
            if(c=='(')
                ost[i++]=c;


            if(c==')')
                if(ost[i-1]!= '(') {
                  break;

                  } else i--;

            if(c=='{')
                ost[i++]=c;

            if(c=='}')
                if(ost[i-1]!= '{') {
                  break;

                  } else i--;

            if(c=='[')
                ost[i++]=c;

            if(c==']')
                if(ost[i-1]!= '[') {
                  break;

                  } else i--;

        }

    }

    if(i > 0)
        printf("niepoprawnie");



    return 0;
}
