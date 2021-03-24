#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
#include <string.h>


#define FILL(t,n,pattern) {\
    const char *p  = #pattern; \
    for(int i = 0 ; i < n ; i++){\
        t[i] = 0; }\
    int d = strlen(#pattern);\
    int i = 0;\
    while(i < 8*n){\
        t[i/8] = t[i/8] | ((p[i%d] - '0') << (7 - (i%8))); \
        i++;}\
   };








int main(void)
{
    char t[10];
    FILL(t,10,01);
    printf("%.10s",t); // UUUUUUUUUU
    FILL(t,10,0110000101100010);
    printf("%.10s",t); // ababababab

    return 0;

}






