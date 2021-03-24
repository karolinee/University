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
    public partial class Form1 : Form
    {
        StudentCityContext context;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            RefreshGrids();
        }

        private void RefreshGrids()
        {
            context = new StudentCityContext();
            dataGridView1.DataSource = context.City.ToList();
            dataGridView2.DataSource = context.Student.ToList();
        }
        private void Button_addCity_Click(object sender, EventArgs e)
        {
            AddCity client = new AddCity("");
            client.ShowDialog();
            RefreshGrids();
        }

        private void Button_remCity_Click(object sender, EventArgs e)
        {
            string name = Convert.ToString(this.dataGridView1.CurrentRow.Cells[0].Value);
            var delCity = context.City.Find(name);
            context.City.Remove(delCity);
            context.SaveChanges();
            RefreshGrids();
        }

        

        private void Button_addStudent_Click(object sender, EventArgs e)
        {
            AddStudent client = new AddStudent(0);
            client.ShowDialog();
            RefreshGrids();
        }
        private void Button_modStudent_Click(object sender, EventArgs e)
        {
            int idx = Convert.ToInt32(this.dataGridView2.CurrentRow.Cells[0].Value);
            AddStudent client = new AddStudent(idx);
            client.ShowDialog();
            RefreshGrids();
        }
        private void Button_remStudent_Click(object sender, EventArgs e)
        {
            int idx = Convert.ToInt32(this.dataGridView2.CurrentRow.Cells[0].Value);
            var delStud = context.Student.Find(idx);

            context.Student.Remove(delStud);
            
            context.SaveChanges();
            RefreshGrids();
        }
    }
}
