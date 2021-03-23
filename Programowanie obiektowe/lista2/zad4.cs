/* Karolina Jeziorska 308220
zadanie 4*/

using System;
using System.Collections.Generic;

namespace zadanie4
{
  class ListaLeniwa
  {
    protected List<int> lista = new List<int>();
    private Random rand = new Random();
    //private int s = 0;

    private void expand(int i)
    {
      for(int j = lista.Count ; j < i ; j++)
      {
        lista.Add(rand.Next());
      }
    }
    virtual public int element(int i)
    {
      if(i > lista.Count)
      {
        expand(i);
      }
      return lista[i-1];
    }
    public int size()
    {
      return lista.Count;
    }
  }

  class Pierwsze : ListaLeniwa
  {
    private bool isPrime(int x)
    {
      if(x <= 1) return false;
      if(x == 2) return true;
      if(x % 2 == 0) return false;

      for(int j = 3; j <= (int)Math.Floor(Math.Sqrt(x)) ; j++)
      {
        if(x % j == 0) return false;
      }
      return true;
    }
    private void expand(int i)
    {
      for(int j = lista.Count ; j < i ; j++)
      {
        if(j == 0)
        {
          lista.Add(2);
        }
        else
        {
          int a = lista[j-1] + 1;
          while(!isPrime(a))
          {
            a++;
          }
          lista.Add(a);

        }
      }

    }
    override public int element(int i)
    {
      if(i > lista.Count)
      {
        expand(i);
      }
      return lista[i-1];
    }

  }

  class Program
  {
    static void Main(string[] args)
    {
      //testy
      //UWAGA! indeksy listy leniwej zaczynaja się od 1 tzn że nie ma elementu 0
      ListaLeniwa listaL = new ListaLeniwa();
      Console.WriteLine(listaL.size());
      Console.WriteLine(listaL.element(40));
      Console.WriteLine(listaL.size());
      Console.WriteLine(listaL.element(38));
      Console.WriteLine(listaL.size());
      Console.WriteLine(listaL.element(40));
      Console.WriteLine(listaL.size());
      Console.WriteLine("-----------------------------------------------------");

      Pierwsze lista = new Pierwsze();

      Console.WriteLine(lista.size());
      Console.WriteLine(lista.element(1));
      Console.WriteLine(lista.size());
      Console.WriteLine(lista.element(2));
      Console.WriteLine(lista.size());
      Console.WriteLine(lista.element(3));
      Console.WriteLine(lista.size());
      Console.WriteLine(lista.element(10));
      Console.WriteLine(lista.size());
      Console.WriteLine("-----------------------------------------------------");

    }
  }
}
