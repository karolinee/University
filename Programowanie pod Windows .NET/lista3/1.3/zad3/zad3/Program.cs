using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad3
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] surnames = File.ReadAllLines(@"../../nazwiska.txt");

            var FirstLetters =
                from surname in surnames
                group surname by surname[0] into first
                orderby first.Key
                select first.Key;

            foreach (var i in FirstLetters) Console.WriteLine(i);

            Console.ReadKey();
        }
    }
}
