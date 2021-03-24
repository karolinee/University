using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _2._3
{
    class Complex : IFormattable
    {
        private readonly double real;
        private readonly double img;

        public Complex(double real, double img)
        {
            this.real = real;
            this.img = img;
        }

        public static Complex operator +(Complex a, Complex b)
        {
            return new Complex(a.real + b.real, a.img + b.img);
        }

        public static Complex operator -(Complex a, Complex b)
        {
            return new Complex(a.real - b.real, a.img - b.img);
        }
        public static Complex operator *(Complex a, Complex b)
        {
            double real = a.real * b.real - a.img * b.img;
            double img = a.real * b.img + a.img * b.real;
            return new Complex(real, img);
        }
        public static Complex operator /(Complex a, Complex b)
        {
            double div = b.real * b.real + b.img * b.img;
            double real = (a.real * b.real + a.img * b.img) / div;
            double img = (a.img * b.real - a.real * b.img) / div;
            return new Complex(real, img);
        }
        public string ToString(string format, IFormatProvider provider)
        {
            if (String.IsNullOrEmpty(format)) format = "d";
            switch (format.ToLower())
            {
                case "w":
                    return $"[{real},{img}]";
                case "d":
                    return $"{real} + {img}i";
                default:
                    throw new FormatException($"Format {format} nie jest obsługiwany, spróbuj w lub d.");
            }
        }
    }
}
