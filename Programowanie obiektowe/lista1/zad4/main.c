#include <stdio.h>
#include "mors.h"
#include <string>

int main()
{
  char *napis = "programowanieObiektowe";

  for(int i = 0 ; i < strlen(napis);i++)
  {
    kodowanie(napis[i]);
  }
}
