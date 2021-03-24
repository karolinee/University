#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(void)
{
    size_t lower = 0 , upper = SIZE_MAX , mid;

    size_t max = lower;

    while(lower < upper)
    {
        mid = (lower + upper)/2;
        void *w = malloc(mid);
        if(w == NULL)
        {
            upper = mid - 1;
        }
        else
        {
            free(w);
            lower = mid;
        }
    }

    printf("%zu",lower);

    return 0;
}
