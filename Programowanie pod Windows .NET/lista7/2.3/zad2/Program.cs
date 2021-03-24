using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad2
{
    class Program
    {
        static void Main(string[] args)
        {
            Set s = new Set();
            Console.WriteLine("Set 2,3,5");
            s.Add(2);
            s.Add(3);
            s.Add(5);
            s.Add(2);
            foreach (var i in s)
                Console.WriteLine(i);
            Console.WriteLine();
            Console.WriteLine("Set 2,3,5 z usuniętym 5");
            s.Remove(5);
            foreach (var i in s)
                Console.WriteLine(i);
            Console.ReadKey();
        }
    }
}
