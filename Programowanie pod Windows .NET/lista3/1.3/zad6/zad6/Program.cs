using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad6
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] logsList = File.ReadAllLines(@"..\..\logs.txt");

            var logs =
               from log in logsList
               select new
               {
                   date = log.Split(' ')[0],
                   ip = log.Split(' ')[1],
                   type = log.Split(' ')[2],
                   name = log.Split(' ')[3],
                   state = log.Split(' ')[4]
               };
            var query =
                (from log in logs
                group log by log.ip into result
                orderby result.Count() descending
                select new
                {
                    ip = result.Key,
                    count = result.Count()
                }).Take(3);

            foreach (var i in query) Console.WriteLine("{0} {1}", i.ip, i.count);
            
            Console.ReadKey();
        }
    }
}
