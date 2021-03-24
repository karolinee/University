using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

namespace zad6
{
    class Program
    {
        static void Main(string[] args)
        {
            char c;

            Console.WriteLine("Podaj literę od której mają zaczynać się nazwiska");
            c = Console.ReadKey().KeyChar;

            Console.WriteLine();

            string path = @"..\..\..\students_list.xml";



            XElement students = XDocument.Load(path).Root;

            var q = from student in students.Descendants("{StudentsData}Student")
                    where ((string)student.Element("{StudentsData}Surname")).StartsWith(c.ToString().ToUpper())
                    select student;

            foreach (var s in q)
            {
                Console.WriteLine(s.Value);
                //ładne wypisanie danych, wypisuje value by pokazać że dobrze znajduje
            }


            Console.ReadKey();
        }
    }
}
