using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;

namespace zad4
{
    class Program
    {
        static void Main(string[] args)
        {
            ReturnMethods(new ExampleClass());
            Console.ReadKey();
        }
        static void ReturnMethods(object o)
        {
            MethodInfo[] methods = o.GetType().GetMethods();
            foreach(MethodInfo _info in methods)
            {
                if(_info.IsPublic && !_info.IsStatic && _info.ReturnType == typeof(int) && _info.GetParameters().Length == 0 && _info.GetCustomAttributes(typeof(Oznakowane), false).Any())
                {
                    Console.WriteLine(_info.Invoke(o, null));
                }
            }
        }
    }
}
