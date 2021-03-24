using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace zad5
{
    public partial class AddCity : Form
    {
        readonly StudentCityContext context;
        readonly string idx;
        public AddCity(string idx)
        {
            context = new StudentCityContext();
            this.idx = idx;
            InitializeComponent();
        }

        private void button_addCity_OK_Click(object sender, EventArgs e)
        {
            if(String.IsNullOrEmpty(idx))
            {
                City newCity = new City
                {
                    CityName = textBox1.Text.Trim()
                };
                context.City.Add(newCity);
            }
            context.SaveChanges();
        }
    }
}
