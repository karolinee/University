using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace zad10
{
    class ReadEmbedded
    {
        public static void Read(string name)
        {
            Console.WriteLine("Odczytuje zasób osadzony..");
            var assembly = Assembly.GetExecutingAssembly();
            var resourceName = assembly.GetManifestResourceNames().Single(str => str.EndsWith(name));

            string result;
            using (Stream st = assembly.GetManifestResourceStream(resourceName))
            using (StreamReader sr = new StreamReader(st))
            {
                result = sr.ReadToEnd();
            }

            Console.WriteLine(result);
        }
    }
}
