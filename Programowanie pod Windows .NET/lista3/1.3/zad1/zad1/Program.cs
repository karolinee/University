using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad1
{
    public static class StringExtension
    {
        public static bool IsPalindrome(this string str)
        {
            int i = 0;
            int j = str.Length - 1;
            while(i < j)
            {
                if (Char.IsWhiteSpace(str[i]) || Char.IsPunctuation(str[i])) { i++; continue; }
                if (Char.IsWhiteSpace(str[j]) || Char.IsPunctuation(str[j])) { j--; continue; }
                if (Char.ToLower(str[i]) != Char.ToLower(str[j])) return false;
                i++;
                j--;
            }
            return true;
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            string s = "Kobyła ma mały bok.";
            string s2 = "Ala ma kota.";
            Console.WriteLine(s.IsPalindrome());
            Console.WriteLine(s2.IsPalindrome());
            Console.ReadKey();
        }
    }
}
