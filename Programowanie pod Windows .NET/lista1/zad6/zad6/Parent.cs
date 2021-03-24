using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad6
{
    
    class Parent
    {
        public void ChildStarted()
        {
            Console.WriteLine("Rodzic zauważa że dziecko zaczęło zadanie");
        }
        public void ChildFinished()
        {
            Console.WriteLine("Rodzic zauważa że dziecko skończyło zadanie");
        }
    }
}
