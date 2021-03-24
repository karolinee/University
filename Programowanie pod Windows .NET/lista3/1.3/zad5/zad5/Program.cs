using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad5
{
    class Program
    {
      
        static void Main(string[] args)
        {
            string[] peopleList = File.ReadAllLines(@"..\..\osoby.txt");
            string[] accountsList = File.ReadAllLines(@"..\..\konta.txt");

            
            var people =
                from personData in peopleList
                select new
                {
                    name = personData.Split(',')[0],
                    surname = personData.Split(',')[1],
                    id = personData.Split(',')[2]
                };
            var accounts =
                from accountData in accountsList
                select new
                {
                    id = accountData.Split(',')[0],
                    number = accountData.Split(',')[1]
                };

            var joined =
                from person in people
                join account in accounts on person.id equals account.id
                select new
                {
                    person.name,
                    person.surname,
                    person.id,
                    account.number
                };

            foreach (var i in joined) Console.WriteLine("{0} {1} {2} {3}", i.name, i.surname, i.id, i.number);
            Console.ReadKey();
        }

    }
}
