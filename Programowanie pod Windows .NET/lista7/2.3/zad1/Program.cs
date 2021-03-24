using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _2._3
{
    class Program
    {
        static void Main(string[] args)
        {
            Complex c1 = new Complex(3, 2);
            Complex c2 = new Complex(4, -5);
            Console.WriteLine("{0}", c1);
            Console.WriteLine("{0:d}", c1);
            Console.WriteLine("{0:w}", c1);
            Console.WriteLine(c1 + c2);
            Console.WriteLine(c1 - c2);
            Console.WriteLine(c1 * c2);
            Console.WriteLine(c1 / c2);
            Console.ReadKey();
        }
    }
}