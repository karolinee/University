using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad7
{
    class Program
    {
        static void Main(string[] args)
        {
            var item = new { Field1 = "The value", Field2 = 5 };
            var item2 = new { Field1 = "The value2", Field2 = 4 };
            var item3 = new { Field1 = "The value3", Field2 = 1 };

            var list = new List<object>()
                .Select(t => new { Field1 = default(string), Field2 = default(int) }).ToList();

            list.Add(item);
            list.Add(item2);
            list.Add(item3);

            foreach (var i in list) Console.WriteLine("{0} {1}", i.Field1, i.Field2);

            Console.ReadKey();

        }
    }
}
