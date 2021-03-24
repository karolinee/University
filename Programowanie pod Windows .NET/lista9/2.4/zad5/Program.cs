using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Schema;

namespace zad5
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = @"..\..\..\students_list.xml";
            XmlDocument xml = new XmlDocument();
            xml.Load(path);


            XmlNodeList nodeList = xml.GetElementsByTagName("Student");    
            
            foreach(XmlNode node in nodeList)
            {
                //Console.WriteLine(node.InnerText);
                Console.WriteLine(String.Format("{0} {1} {2} {3}", node["Name"].InnerText, node["Surname"].InnerText, node["Date_of_birth"].InnerText, node["Adress_temp"]["City"].InnerText));
                //plus wypiszanie pozostałych elementów...
            }

            //dodanie elementu
            XmlNode root = xml.GetElementsByTagName("Students")[0];
            XmlNode st = xml.CreateElement("Student", xml.DocumentElement.NamespaceURI);
            XmlNode name = xml.CreateElement("Name", xml.DocumentElement.NamespaceURI);
            name.InnerText = "Alija";
            st.AppendChild(name);

            XmlNode sname = xml.CreateElement("Surname", xml.DocumentElement.NamespaceURI);
            sname.InnerText = "Kowalczyk";
            st.AppendChild(sname);

            XmlNode dd = xml.CreateElement("Date_of_birth", xml.DocumentElement.NamespaceURI);
            dd.InnerText = "1999-05-05";
            st.AppendChild(dd);

            XmlNode adp = xml.CreateElement("Adress_pernam", xml.DocumentElement.NamespaceURI);

            XmlNode city = xml.CreateElement("City", xml.DocumentElement.NamespaceURI);
            city.InnerText = "Wrocław";

            adp.AppendChild(city);
            st.AppendChild(adp);

            XmlNode adt = xml.CreateElement("Adress_temp", xml.DocumentElement.NamespaceURI);
            XmlNode city2 = xml.CreateElement("City", xml.DocumentElement.NamespaceURI);
            city.InnerText = "Wieluń";

            adt.AppendChild(city2);
            st.AppendChild(adt);


            XmlNode cc = xml.CreateElement("Classes", xml.DocumentElement.NamespaceURI);
            XmlNode c = xml.CreateElement("Class", xml.DocumentElement.NamespaceURI);
            XmlNode n = xml.CreateElement("Name", xml.DocumentElement.NamespaceURI);
            n.InnerText = "Algebra";
            XmlNode grade = xml.CreateElement("Grade", xml.DocumentElement.NamespaceURI);
            grade.InnerText = "5";
            c.AppendChild(n);
            c.AppendChild(grade);
            cc.AppendChild(c);
            st.AppendChild(cc);

            root.AppendChild(st);

            xml.Save(path);
            
            Console.ReadKey();
        }

    }

    
}
