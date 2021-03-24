using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad4
{
    
    class Program
    {
        static void Main()
        {
            using(var context = new StudentCityContext())
            {
                try
                {
                    var nCity = new City
                    {
                        CityName = "Wrocław"
                    };
                    context.City.Add(nCity);
                    context.SaveChanges();

                    //dodawanie
                    var newStudent = new Student
                    {
                        Name = "Ala",
                        Surname = "Kowalska",
                        CityName = "Wrocław",
                        DateOfBirth = new DateTime(1999, 2, 18)
                    };
                    context.Student.Add(newStudent);
                    context.SaveChanges();
                    Console.WriteLine("Dodano rekord do tabeli student");
                    Console.ReadKey();

                    //modyfikowanie dodanego elementu
                    var modQuerry = context.Student.Where(p => p.Name == "Ala");
                    foreach (var mod in modQuerry)
                    {
                        mod.Name = "Alicja";
                    }
                    context.SaveChanges();
                    Console.WriteLine("Zmodyfikowano rekord w tabeli student");
                    Console.ReadKey();

                    //usuwanie
                    var delQuerry = context.Student.Where(p => p.Name == "Alicja");
                    foreach (var del in delQuerry)
                    {
                        context.Student.Remove(del);
                    }
                    context.SaveChanges();
                    Console.WriteLine("Usunięto rekordy z tabeli student");
                    Console.ReadKey();

                    //dodawanie miasta i studenta z miasta
                    var newCity = new City
                    {
                        CityName = "Gdańsk"
                    };
                    context.City.Add(newCity);

                    var newStudent2 = new Student
                    {
                        Name = "Bartosz",
                        Surname = "Kowal",
                        DateOfBirth = new DateTime(1999, 03, 03),
                        City = newCity
                    };
                    context.Student.Add(newStudent2);

                    context.SaveChanges();
                    Console.WriteLine("Dodano miejscowość i studenta z tej miejscowości");
                }
                catch(Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }
            Console.ReadKey();
        }
    }

    public class StudentCityContext: DbContext
    {
        public StudentCityContext() : base("cs")
        {

        }

        public StudentCityContext(string connectionString) : base(connectionString)
        {

        }
        public DbSet<Student> Student { get; set; }
        public DbSet<City> City { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder
                .Entity<City>()
                .Property(s => s.CityName)
                .IsRequired()
                .HasMaxLength(20);
            modelBuilder
                .Entity<City>()
                .HasMany(c => c.Students)
                .WithRequired(s => s.City)
                .HasForeignKey(s => s.CityName);

            modelBuilder
                .Entity<Student>()
                .Property(s => s.Name)
                .IsRequired()
                .HasMaxLength(20);
            modelBuilder
                .Entity<Student>()
                .Property(s => s.Surname)
                .IsRequired()
                .HasMaxLength(20);
            
        }
    }
    public class Student
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public DateTime DateOfBirth { get; set; }
        
        public string CityName { get; set; }
        public virtual City City { get; set; }
    }

    public class City
    {
        [Key]
        public string CityName { get; set; }
        public virtual ICollection<Student> Students { get; set; }
    }
}
