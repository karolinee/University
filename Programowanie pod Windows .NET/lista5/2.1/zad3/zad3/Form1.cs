using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing;
using System.Drawing.Drawing2D;

namespace zad3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            timer1.Interval = 50;
            timer1.Start();

            this.SetStyle(ControlStyles.UserPaint, true);
            this.SetStyle(ControlStyles.AllPaintingInWmPaint, true);
            this.SetStyle(ControlStyles.OptimizedDoubleBuffer, true);
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            this.Invalidate();
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            double width = 300;
            double height = 300;
            Graphics g = e.Graphics;
            g.SmoothingMode = SmoothingMode.AntiAlias;

            DateTime time = DateTime.Now;
            int hour = time.Hour % 12;
            int minute = time.Minute;
            int second = time.Second;

            double hourRadian = hour * 360 / 12 * Math.PI / 180;
            double minRadian = minute * 360 / 60 * Math.PI / 180;
            double secRadian = second * 360 / 60 * Math.PI / 180;

            
            double hourX = 0.5 * width * Math.Sin(hourRadian);
            double hourY = 0.5 * height * Math.Cos(hourRadian);
            double minX = 0.75 * width * Math.Sin(minRadian);
            double minY = 0.75 * height * Math.Cos(minRadian);
            double secX = 0.9 *width  * Math.Sin(secRadian);
            double secY = 0.9 * height * Math.Cos(secRadian);

            
            g.FillEllipse(Brushes.White,(float) (this.Width / 2 - width), (float)(this.Height / 2 - height), (float)(2 * width),(float)( 2 * height));
            g.DrawLine(new Pen(Color.Red, 1), this.Width / 2, this.Height / 2, this.Width / 2 + (float)secX, this.Height / 2 - (float)secY);
            g.DrawLine(new Pen(Color.Black, 2), this.Width / 2, this.Height / 2, this.Width / 2 +  (float)minX, this.Height / 2 - (float)minY);
            g.DrawLine(new Pen(Color.Black, 3), this.Width / 2, this.Height / 2, this.Width / 2 +  (float)hourX, this.Height / 2 - (float)hourY);

            using (Font f = new Font("Courier", 24))
            {
                for (int i = 1; i <= 12; i++)
                    g.DrawString(i.ToString(), f, Brushes.Black, (float)(this.Width / 2 + 0.9* width * Math.Sin(Math.PI * i / 6) - g.MeasureString(i.ToString(), f).Width / 2), (float)(this.Height / 2 - 0.9 *  height * Math.Cos(Math.PI * i / 6) - g.MeasureString(i.ToString(), f).Height/2));

            }
            
        }
    }
}
