#include <stdio.h>
#include <stdlib.h>


int main()
{
    double k=1.0;
    const int n=999;

    for(int i=1; i<=n ; i++)
    {
        double s=1.0*(-((i%2)*2-1))/((2*i+1)*(2*i+1));

        k+=s;

        printf("%.8f\n", k);
    };



    return 0;


}
