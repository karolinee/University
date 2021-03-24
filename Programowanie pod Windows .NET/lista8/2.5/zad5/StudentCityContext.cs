using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad5
{
    public class StudentCityContext : DbContext
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
}
