using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad6
{
    delegate void AssigmentReaction();
    class Program
    {
        static void Main(string[] args)
        {
            Student s = new Student();
            Parent p = new Parent();
            Teacher t = new Teacher();

            s.AssigmentStarted += new AssigmentReaction(p.ChildStarted);
            s.AssigmentFinished += new AssigmentReaction(p.ChildFinished);
            s.AssigmentFinished += new AssigmentReaction(t.MarkFinished);

            for(int i = 0; i < 3; i ++)
            {
                s.Work();
            }

            Console.ReadKey();
        }
    }
}
