using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad1
{
    class Program
    {
        static int Foo1(int x, int y)
        {
            return x + y;
        }
        static dynamic Foo2(dynamic x, dynamic y)
        {
            return x + y;
        }
        static void Main(string[] args)
        {
            int MAX = 10000;
            int result1;
            dynamic result2;
            
            DateTime start = DateTime.Now;
            for (int i = 0; i <= MAX; i++) result1 = Foo1(i, i);
            DateTime end = DateTime.Now;

            TimeSpan time = end - start;
            Console.WriteLine("Metoda z typem konkretnym - {0}", time);

            start = DateTime.Now;
            for (int i = 0; i <= MAX; i++) result2 = Foo2(i, i);
            end = DateTime.Now;

            time = end - start;
            Console.WriteLine("Metoda z typem dynamicznym - {0}", time);

            Console.ReadKey();
        }
    }
}
