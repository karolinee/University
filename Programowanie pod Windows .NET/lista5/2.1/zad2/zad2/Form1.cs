using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace zad2
{
    
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            InitializeListView();
            InitializeTreeView();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            progressBar1.Increment(1);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            timer1.Start();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            timer1.Stop();
            progressBar1.Value = progressBar1.Minimum;
        }

        private void InitializeListView()
        {
            ListViewItem lv = listView1.Items.Add("Jan");
            lv.SubItems.Add("Kowalski");
            lv.SubItems.Add("20");

            lv = listView1.Items.Add("Adam");
            lv.SubItems.Add("Mazur");
            lv.SubItems.Add("4");

            lv = listView1.Items.Add("Damian");
            lv.SubItems.Add("Nowak");
            lv.SubItems.Add("40");
        }

        private void InitializeTreeView()
        {
            treeView1.Nodes.Add("Books");
            treeView1.Nodes.Add("Magazines");

            treeView1.Nodes[0].Nodes.Add("Book1");
            treeView1.Nodes[0].Nodes.Add("Book2");

            treeView1.Nodes[1].Nodes.Add("Magazine1");
        }

        private void listView1_ColumnClick(object sender, ColumnClickEventArgs e)
        {

            listView1.ListViewItemSorter = new ListViewSorter(e.Column);
        }
    }
    public class ListViewSorter : IComparer
    {
        int column;

        public ListViewSorter(int c)
        {
            this.column = c;
        }
        public int Compare(object o1, object o2)
        {
            ListViewItem i1 = o1 as ListViewItem;
            ListViewItem i2 = o2 as ListViewItem;
            if (column == 2)
            {
                return Int32.Parse(i1.SubItems[column].Text).CompareTo(Int32.Parse(i2.SubItems[column].Text));
            }
            return string.Compare(i1.SubItems[column].Text, i2.SubItems[column].Text);
        }
    }
}
