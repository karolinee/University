using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad4
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = "..\\..\\test";

            DirectoryInfo dir = new System.IO.DirectoryInfo(path);
            FileInfo[] files = dir.GetFiles("*.*", System.IO.SearchOption.TopDirectoryOnly);
  
            var Query =
                from file in files
                select file.Length;

            long lengthSum = Query.Aggregate((x, y) => x + y);
            Console.WriteLine(lengthSum);
            Console.ReadKey();

        }
    }
}
