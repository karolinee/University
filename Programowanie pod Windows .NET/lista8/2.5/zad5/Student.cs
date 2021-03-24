using System;

namespace zad5
{
    public class Student
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public DateTime DateOfBirth { get; set; }

        public string CityName { get; set; }
        public virtual City City { get; set; }
    }
}
