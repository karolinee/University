using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad8
{
    class Program
    {
        static void Main(string[] args)
        {
            List<int> list = new List<int>() { 1, 2, 3, 4, 5 };

            Func<int, int> fib = null;

            foreach (var item in list.Select(fib = i => i > 2 ? fib(i-1) + fib(i-2) : 1))
                Console.WriteLine(item);

            Console.ReadKey();
        }
    
    }
}
