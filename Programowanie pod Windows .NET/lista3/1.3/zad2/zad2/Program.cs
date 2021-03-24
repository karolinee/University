using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad2
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] lines = File.ReadAllLines(@"..\..\liczby.txt");
            int[] numbers = Array.ConvertAll(lines, s => int.Parse(s));
           
            var NumQuery1 =
                from num in numbers
                where num > 100
                orderby num descending
                select num;

            var NumQuery2 = numbers.Where(x => x > 100).OrderByDescending(x => x);
       
            //funkcje LINQ przyjmują typ funkcyjny (uogólniony Func<>)
            //natomiast operatory nie wymagają lambda wyrażeń ale samych wyrażeń

            Console.WriteLine("Wyrażenie LINQ:");
            foreach (int num in NumQuery1)  Console.WriteLine(num);
            

            Console.WriteLine("\nCiąg wyrażeń LINQ:");
            foreach (int num in NumQuery2) Console.WriteLine(num);

            Console.ReadKey();

        }
    }
}
