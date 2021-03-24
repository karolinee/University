using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad6
{
    
    class Student
    {
        int tasktodo = 1;
        readonly AssigmentList assigments = new AssigmentList();
        public void Work()
        {

            Console.WriteLine("Uczeń rozpoczął zadanie " + assigments[tasktodo]);
            AssigmentStarted?.Invoke();

            Console.WriteLine("Uczeń pracuje");
            AssigmentInProgress?.Invoke();

            Console.WriteLine("Uczen skończył pracę");
            AssigmentFinished?.Invoke();
            tasktodo++;
        }
        public event AssigmentReaction AssigmentStarted;
        public event AssigmentReaction AssigmentInProgress;
        public event AssigmentReaction AssigmentFinished;
    }
}
