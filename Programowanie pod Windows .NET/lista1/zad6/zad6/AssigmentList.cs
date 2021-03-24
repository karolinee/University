using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad6
{
    class AssigmentList
    {
        public string this[int i]
        {
            get
            {
                switch(i)
                {
                    case 1:
                        return "Zadanie A";
                    case 2:
                        return "Zadanie B";
                    default:
                        return "Zadanie X";
                }
            }
        }
    }
}
