using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad1
{
    public class Algorithm
    {
        private static bool Check(int n)
        {
            int sum = 0;
            int temp = n;
            while (temp != 0)
            {
                int digit = temp % 10;
                if (digit != 0 && n % digit != 0) return false;
                sum += digit;
                temp /= 10;
            }
            return n % sum == 0;
        }
        public static void writeSolution()
        {
            for (int i = 1; i <= 10000; i++)
                if (Check(i)) Console.WriteLine(i);
        }
    }
}
