using System;
using List;

namespace zadanie1
{
    class Program
    {
        static void Main(string[] args)
        {
            Lista<int> l = new Lista<int>();

            l.addBeg(4);
            l.addBeg(5);
            l.addEnd(3);

            Console.WriteLine(l.removeEnd());
            Console.WriteLine(l.removeBeg());

            Console.WriteLine(l.isEmpty());
            Console.WriteLine(l.removeEnd());

            Console.WriteLine(l.isEmpty());
        }
    }

}
