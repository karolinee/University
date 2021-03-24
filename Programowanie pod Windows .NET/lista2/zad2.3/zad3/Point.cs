using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad3
{
    class Point
    {
        public int X { get; set; }
        public int Y { get; set; }

        public Point(int x, int y)
        {
            X = x;
            Y = y;
        }
        public override string ToString()
        {
            return $"({X},{Y})";
        }

        public static int Compare(Point p1, Point p2)
        {
            if (p1.X == p2.X)
                return p1.Y.CompareTo(p2.Y);
            return p1.X.CompareTo(p2.X);
        }
    }
}
