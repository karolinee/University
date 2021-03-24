using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace zad1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            string checkBoxText = "";
            if (checkBox1.CheckState == CheckState.Checked) checkBoxText += checkBox1.Text + " ";
            if (checkBox2.CheckState == CheckState.Checked) checkBoxText += checkBox2.Text;
            MessageBox.Show(textBox1.Text + "\n" + textBox2.Text + "\n" + comboBox1.SelectedItem + "\n" + checkBoxText, "Uczelnia", MessageBoxButtons.OK, MessageBoxIcon.None);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
