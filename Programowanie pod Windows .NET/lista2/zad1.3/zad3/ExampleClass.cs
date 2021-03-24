using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad3
{
    class ExampleClass
    {
        private int _privateProperty;
        private int _publicProperty;

        private int PrivateProperty { get; set; }
        public int PublicProperty { get; set; }
        private void PrivateMethod()
        {
            Console.WriteLine("Jest to metoda prywatna");
        }
        public void PublicMethod()
        {
        }

    }
}
