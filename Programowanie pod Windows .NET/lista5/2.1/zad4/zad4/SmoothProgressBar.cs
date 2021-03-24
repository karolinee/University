using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing;
using System.Drawing.Drawing2D;


namespace zad4
{
    class SmoothProgressBar : UserControl
    {
        public SmoothProgressBar() { }

        private int min;
        public int Min 
        {
            get => min;
            set
            {
                min = value;
                if (Value < min) min = Value;
                if (min > Max) min = Max - 1;
                this.Invalidate();
            }
        }

        private int max;
        public int Max
        {
            get => max;
            set
            {
                max = value;
                if (Value > max) max = Value;
                if (max < Min) max = Min + 1;
                this.Invalidate();

            }
        }

        private int val;
        public int Value
        {
            get => val;
            set
            {
                int oldVal = val;
                val = value;
                if (val < Min) val = Min;
                if (val > Max) val = Max;
                
                //wyznaczenie kawałka do rysowania

                Rectangle newValueRect = this.ClientRectangle;
                Rectangle oldValueRect = this.ClientRectangle;

                float percent = (float)(val - min) / (float)(max - min);
                newValueRect.Width = (int)((float)newValueRect.Width * percent);

                percent = (float)(oldVal - min) / (float)(max - min);
                oldValueRect.Width = (int)((float)oldValueRect.Width * percent);

                Rectangle updateRect = new Rectangle();

                updateRect.X = oldValueRect.Size.Width;
                updateRect.Width = newValueRect.Width - oldValueRect.Width;

                updateRect.Height = this.ClientRectangle.Height;
               
                this.Invalidate(updateRect);
            }
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            Graphics g = e.Graphics;
            float percent = (float)(Value - Min) / (float)(Max - Min);
            Rectangle rect = this.ClientRectangle;
            rect.Width = (int)((float)rect.Width * percent);
            using (LinearGradientBrush brush = new LinearGradientBrush(this.ClientRectangle, Color.LightGreen, Color.Green, -45f, false))
            {
                g.FillRectangle(brush, rect);
            }
            

            int PenWidth = (int)Pens.White.Width;

            g.DrawLine(Pens.DarkGray,
            new Point(this.ClientRectangle.Left, this.ClientRectangle.Top),
            new Point(this.ClientRectangle.Width - PenWidth, this.ClientRectangle.Top));
            g.DrawLine(Pens.DarkGray,
            new Point(this.ClientRectangle.Left, this.ClientRectangle.Top),
            new Point(this.ClientRectangle.Left, this.ClientRectangle.Height - PenWidth));
            g.DrawLine(Pens.White,
            new Point(this.ClientRectangle.Left, this.ClientRectangle.Height - PenWidth),
            new Point(this.ClientRectangle.Width - PenWidth, this.ClientRectangle.Height - PenWidth));
            g.DrawLine(Pens.White,
            new Point(this.ClientRectangle.Width - PenWidth, this.ClientRectangle.Top),
            new Point(this.ClientRectangle.Width - PenWidth, this.ClientRectangle.Height - PenWidth));
        }

    }
}
