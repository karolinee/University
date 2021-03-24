using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad3
{
    class Program
    {
  
        static void Main(string[] args)
        {
            List<Point> points = new List<Point>();
            points.Add(new Point(0, 4));
            points.Add(new Point(6, 0));
            points.Add(new Point(-2, 3));
            points.Add(new Point(1, -5));
            points.Add(new Point(4, 4));
            points.Add(new Point(-1, -2));
            points.Add(new Point(-5, 0));
            points.Add(new Point(0, 0));

            Console.WriteLine("Lista punktów");
            foreach (var p in points)
                Console.Write(p.ToString() + " ");
            Console.WriteLine("\n");

            Console.WriteLine("Sortowanie punktów");
            points.Sort(delegate (Point p1, Point p2)
            {
               if(p1.X == p2.X) return p1.Y.CompareTo(p2.Y);
               return p1.X.CompareTo(p2.X);
            });
            foreach (var p in points)
                Console.Write(p.ToString() + " ");
            Console.WriteLine("\n");

            Console.WriteLine("Foreach - wyliczenie odległości między punktem a środkiem układu");
            points.ForEach(delegate (Point p)
            {
                double result = Math.Sqrt(Math.Pow(p.X, 2) + Math.Pow(p.Y, 2));
                Console.Write(result + " ");
            });
            Console.WriteLine("\n");

            Console.WriteLine("Usunięcie punktów poniżej osi x");
            int count = points.RemoveAll(delegate (Point p)
            {
                return p.X < 0;
            });
            Console.WriteLine(count);
            foreach (var p in points)
                Console.Write(p.ToString() + " ");
            Console.WriteLine("\n");

            Console.WriteLine("Wszystkie punkty o x dodatnich");
            List<Point> points_positivex = points.FindAll(delegate (Point p)
            {
                return p.X > 0;
            });
            foreach (var p in points_positivex)
                Console.Write(p.ToString() + " ");
            Console.WriteLine("\n");

            Console.WriteLine("Konwersja - zwiększenie każdej wartości punktu o 1");
            List<Point> points_increased = points.ConvertAll(delegate (Point p)
             {
                 return new Point(p.X + 1, p.Y + 1);
             });
            foreach (var p in points_increased)
                Console.Write(p.ToString() + " ");
            Console.WriteLine("\n");


            



            Console.ReadKey();

        }
    }
}
