using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;

namespace zad3
{
    class Program
    {
        static void Main(string[] args)
        {
            ExampleClass exampleC = new ExampleClass();

            MethodInfo privMethod = exampleC.GetType().GetMethod("PrivateMethod", BindingFlags.Instance | BindingFlags.NonPublic);
            privMethod.Invoke(exampleC,null);

            PropertyInfo privProperty = exampleC.GetType().GetProperty("PrivateProperty", BindingFlags.Instance | BindingFlags.NonPublic);
            privProperty.SetValue(exampleC, 14);
            int val = (int)privProperty.GetValue(exampleC, null);
            Console.WriteLine("Wartość właściwości prywatnej: " + val);


            int max = 100000;

            int temp = 0;
            DateTime start = DateTime.Now;
            while(temp <= max)
            {
                exampleC.PublicMethod();
                temp++;
            }
            DateTime end = DateTime.Now;
            TimeSpan time = end - start;
            Console.WriteLine("Access to method without reflection: " + time);

            temp = 0;
            start = DateTime.Now;
            while (temp <= max)
            {
                exampleC.GetType().GetMethod("PublicMethod", BindingFlags.Instance | BindingFlags.Public).Invoke(exampleC, null);
                temp++;
            }
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("Access to method with reflection: " + time);


            temp = 0;
            start = DateTime.Now;
            end = DateTime.Now;
            int i;
            while(temp<= max)
            {
                exampleC.PublicProperty = 19;
                i = exampleC.PublicProperty;
                temp++;
            }
            time = end - start;
            Console.WriteLine("Access to property without reflection: " + time);

            temp = 0;
            start = DateTime.Now;
            while (temp <= max)
            {
                exampleC.GetType().GetProperty("PublicProperty", BindingFlags.Instance | BindingFlags.Public).SetValue(exampleC, 14);
                i = (int)exampleC.GetType().GetProperty("PublicProperty", BindingFlags.Instance | BindingFlags.Public).GetValue(exampleC, null);
                temp++;
            }
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("Access to property with reflection: " + time);

            Console.ReadKey();

        }
    }
}

