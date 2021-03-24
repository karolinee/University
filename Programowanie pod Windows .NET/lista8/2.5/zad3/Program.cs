using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad3
{
    class Program
    {
        static void Main()
        {
            //kod napisany do wykonywania się na bazie opisanej w pliku tekstowym "zad2.txt"
            using(var context = new zad2DataContext())
            {
                //dodanie elementu
                try
                {
                    var newC = new miejscowosc
                    {
                        nazwa = "Kraków"
                    };
                    context.miejscowosc.InsertOnSubmit(newC);
                    context.SubmitChanges();
                    var newStudent = new student
                    {
                        imie = "Ala",
                        nazwisko = "Kowalska",
                        miejsceZamieszkania = "Kraków",
                        dataUrodzenia = new DateTime(1999, 2, 18)
                    };
                    context.student.InsertOnSubmit(newStudent);
                    context.SubmitChanges();
                    Console.WriteLine("Dodano rekord do tabeli student");
                    Console.ReadKey();

                    //modyfikowanie dodanego elementu
                    var modQuerry = context.student.Where(p => p.imie == "Ala");
                    foreach (var mod in modQuerry)
                    {
                        mod.imie = "Alicja";
                    }
                    context.SubmitChanges();
                    Console.WriteLine("Zmodyfikowano rekord w tabeli student");
                    Console.ReadKey();

                    //usunięcie elementu
                    var delQuerry = context.student.Where(p => p.imie == "Alicja");
                    foreach (var del in delQuerry)
                    {
                        context.student.DeleteOnSubmit(del);
                    }
                    context.SubmitChanges();
                    Console.WriteLine("Usunięto rekordy z tabeli student");
                    Console.ReadKey();


                    //dodanie nowej miejscowości i studenta z tej miejsowości
                    var newCity = new miejscowosc
                    {
                        nazwa = "Sopot"
                    };
                    context.miejscowosc.InsertOnSubmit(newCity);

                    var newStudent2 = new student
                    {
                        imie = "Anna",
                        nazwisko = "Nowak",
                        dataUrodzenia = new DateTime(1999, 4, 26)
                    };
                    newStudent2.miejscowosc = newCity;
                    context.student.InsertOnSubmit(newStudent2);
                    context.SubmitChanges();
                    Console.WriteLine("Dodano miejscowość i studenta z tej miejscowości");
                }
                catch(Exception e)
                {
                    Console.WriteLine(e.Message);
                }
                Console.ReadKey();
            }
        }        
    }
}
