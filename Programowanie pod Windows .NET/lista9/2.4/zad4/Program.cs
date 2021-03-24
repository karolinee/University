using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace zad4
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlSerializer xS = new XmlSerializer(typeof(Students));


            string path = @"..\..\..\students_list.xml";
            FileStream fs = new FileStream(path, FileMode.Open);
            Students data = (Students)xS.Deserialize(fs);

            //wypisanie
            foreach(StudentsStudent s in data.Student)
            {
                Console.WriteLine(String.Format("{0} {1} {2}", s.Name, s.Surname, s.Date_of_birth));
            }

            //dodanie nowego studenta
            StudentsStudent st = new StudentsStudent();

            st.Name = "Jan";
            st.Surname = "Kowalski";
            st.Date_of_birth = new DateTime(1999, 12, 12);
            st.Adress_pernam = new StudentsStudentAdress_pernam
            {
                City = "Wrocław"
            };
            st.Adress_temp = new StudentsStudentAdress_temp
            {
                City = "Gdańsk"
            };
            st.Classes = new StudentsStudentClass[]
            {
                new StudentsStudentClass{Name = "Bazy", Grade = 5}
            };

            data.Student.Add(st);

            fs.SetLength(0);
            xS.Serialize(fs,data);

            fs.Close();

            Console.ReadKey();
        }
    }
}
