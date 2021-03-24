using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad4
{
    class Oznakowane : Attribute
    {

    }
    class ExampleClass
    {
        [Oznakowane]
        public int Foo()
        {
            return 1;
        }

        public int Boo()
        {
            return 2;
        }

        private int Foo2()
        {
            return 3;
        }
        public double Foo3()
        {
            return 4;
        }
        public int Foo4(int i)
        {
            return 5;
        }
        [Oznakowane]
        public int Bar2()
        {
            return 6;
        }

        [Oznakowane]
        public double Bar3()
        {
            return 7;
        }
    }
}
