using System;
using SlownikLibrary;

namespace zadanie2
{
    class Program
    {
        static void Main(string[] args)
        {
            Slownik<int,int> a = new Slownik<int,int>();
            a.add(2,3);
            a.add(5,5);


            Console.WriteLine(a.search(5));

            a.add(5,4);
            a.add(6,7);

            Console.WriteLine(a.search(6));

            a.remove(6);
            Console.WriteLine(a.search(6));

            a.add(5,7);
            Console.WriteLine(a.search(5));
        }
    }

}
