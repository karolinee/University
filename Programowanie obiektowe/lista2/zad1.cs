/* Karolina Jeziorska 308220
zadanie 1*/

using System;

namespace zadanie1
{
  class IntStream
  {
    protected int number = 0;
    protected bool end = false;

    virtual public int next()
    {
      if(number == Int32.MaxValue)
      {
        end = true;
        return number;
      }
      else
      {
        return number++;
      }
    }

    public void reset()
    {
      number = 0;
      end = false;
    }

    virtual public bool eos()
    {
      return end;
    }
  }

  class PrimeStream : IntStream
  {
    private bool isPrime()
    {
      if(number <= 1) return false;
      if(number == 2) return true;
      if(number % 2 == 0) return false;

      for(int i = 3; i <= (int)Math.Floor(Math.Sqrt(number)) ; i++)
      {
        if(number % i == 0) return false;
      }
      return true;
    }
    private void prime()
    {
      while(number < Int32.MaxValue && !isPrime())
      {
        number++;
      }
    }
    override public int next()
    {
      if(number == Int32.MaxValue)
      {
        end = true;
        return number;
      }
      else
      {
        prime();
        if((number == Int32.MaxValue))
          return number;
        else
        {
          return number++;
        }

      }
    }
  }

  class RandomStream : IntStream
  {
    Random rand = new Random();
    override public int next()
    {
      number = rand.Next();
      return number;
    }

    override public bool eos()
    {
      return false;
    }
  }

  class RandomWordStream
  {
    private string alpanumeric = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    PrimeStream prime = new PrimeStream();
    RandomStream r = new RandomStream();

    public string next()
    {
      int end = prime.next();
      string s = "";
      for(int i = 0 ; i < end;i++)
      {
        s+=alpanumeric[r.next() % alpanumeric.Length];
      }
      return s;
    }
  }

  class Program
  {
    static void Main(string[] args)
    {
      //testy
      IntStream stream = new IntStream();
      Console.WriteLine("IntStream");
      for(int i = 0 ; i < 5 ; i++)
      {
        Console.WriteLine("{0} {1}",stream.next(),stream.eos());
      }
      Console.WriteLine("reset");
      stream.reset();
      for(int i = 0 ; i < 3 ; i++)
      {
        Console.WriteLine("{0} {1}",stream.next(),stream.eos());
      }
      Console.WriteLine("------------------------------------------------------");


      PrimeStream stream2 = new PrimeStream();
      Console.WriteLine("PrimeStream");
      for(int i = 0 ; i < 5 ; i++)
      {
        Console.WriteLine("{0} {1}",stream2.next(),stream2.eos());
      }
      Console.WriteLine("reset");
      stream2.reset();
      for(int i = 0 ; i < 3 ; i++)
      {
        Console.WriteLine("{0} {1}",stream2.next(),stream2.eos());
      }
      Console.WriteLine("------------------------------------------------------");

      RandomStream stream3 = new RandomStream();
      Console.WriteLine("RandomStream");
      for(int i = 0 ; i < 5 ; i++)
      {
        Console.WriteLine("{0} {1}",stream3.next(),stream3.eos());
      }
      Console.WriteLine("------------------------------------------------------");

      RandomWordStream stream4 = new RandomWordStream();
      Console.WriteLine("RandomWordStream");
      for(int i = 0 ; i < 10 ; i++)
      {
        Console.WriteLine(stream4.next());
      }
    }
  }
}
