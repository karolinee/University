using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Schema;

namespace zad3
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlDocument xml = new XmlDocument();

            string path = @"..\..\..\students_list.xml";
            XmlTextReader tr = new XmlTextReader(path);
            XmlValidatingReader reader = new XmlValidatingReader(tr);

            reader.ValidationType = ValidationType.Schema;
            reader.ValidationEventHandler += new ValidationEventHandler(ValidationHandler);

            xml.Load(reader);

            Console.WriteLine("Wczytano plik");
            Console.ReadKey();
        }
        public static void ValidationHandler(object sender, ValidationEventArgs args)
        {
            Console.WriteLine("***BŁĄD WALIDACJI***");
            Console.WriteLine("\tWażność: {0}", args.Severity);
            Console.WriteLine("\tInfo:    {0}", args.Message);

        }
    }
}
