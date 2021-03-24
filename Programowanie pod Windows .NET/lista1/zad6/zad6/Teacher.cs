using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad6
{
    class Teacher
    {
        private static Random rnd = new Random();
        public void MarkFinished()
        {
            int mark = rnd.Next(1,6);
            Console.WriteLine("Nauczyciel ocenil pracę na " + mark);
        }
    }
}
