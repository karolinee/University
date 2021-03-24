using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad4
{
    class Program
    {
        static void Main(string[] args)
        {
            List<double> list = new List<double>
            {
                5.7,
                6.3,
                0,
                -2.77,
                3.33333
            };

            Console.WriteLine("Lista początkowa");
            foreach (double i in list) Console.Write(i + " ");
            Console.WriteLine();

            Console.WriteLine("Konwersja na int");
            List<int> list2 = ListHelper.ConvertAll(list, new Converter<double, int>(ConvertDoubleInt));
            foreach (int i in list) Console.Write(i + " ");
            Console.WriteLine("\n");

            Console.WriteLine("Znajdź wszystkie elementy dodatnie");
            List<int> list3 = ListHelper.FindAll(list2, x => x > 0);
            foreach (int i in list3) Console.Write(i + " ");
            Console.WriteLine("\n");

            Console.WriteLine("Foreach (wypisz)");
            ListHelper.ForEach(list2, x => Console.Write(x + " "));
            Console.WriteLine("\n");

            Console.WriteLine("Sortowanie");
            ListHelper.Sort(list2, CompareInt);
            foreach (int i in list2) Console.Write(i + " ");
            Console.WriteLine("\n");

            Console.WriteLine("Usunięcie wszystkich elementów parzystych");
            int removed = ListHelper.RemoveAll(list2, x => x % 2 == 0);
            Console.WriteLine("Usunięto {0} elementów", removed);
            foreach (int i in list2) Console.Write(i + " ");
            Console.WriteLine();

            Console.ReadKey();
        }
        public static int ConvertDoubleInt(double i)
        {
            return (int)i;
        }
        public static int CompareInt(int i, int j)
        {
            if (i < j) return -1;
            if (i == j) return 0;
            return 1;
        }
    }
}
