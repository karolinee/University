using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace zad5
{
    public partial class AddStudent : Form
    {
        readonly StudentCityContext context = new StudentCityContext();
        readonly int idx;
        public AddStudent(int idx)
        {
            this.idx = idx;
            InitializeComponent();
        }

        private void button_addStudent_OK_Click(object sender, EventArgs e)
        {
            if(idx > 0)
            {
                var s = context.Student.Find(idx);
                
                if (!String.IsNullOrEmpty(text_name.Text.Trim())) s.Name = text_name.Text.Trim();
                if (!String.IsNullOrEmpty(text_surname.Text.Trim())) s.Surname = text_surname.Text.Trim();
                if (!String.IsNullOrEmpty(text_birth.Text.Trim())) s.DateOfBirth = DateTime.Parse(text_birth.Text.Trim());
                if (!String.IsNullOrEmpty(text_place.Text.Trim())) s.CityName = text_place.Text.Trim();
            }
            else
            {
                Student newStudent = new Student
                {
                    Name = text_name.Text.Trim(),
                    Surname = text_surname.Text.Trim(),
                    DateOfBirth = DateTime.Parse(text_birth.Text.Trim()),
                    CityName = text_place.Text.Trim()
                };
                context.Student.Add(newStudent);
            }
            
            context.SaveChanges();
        }
    }
}
