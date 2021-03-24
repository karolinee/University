using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad1
{
    class Compare
    {
        const int max = 100000;
        static ArrayList arraylist = new ArrayList();
        static List<int> list = new List<int>();
        static Hashtable hashtable = new Hashtable();
        static Dictionary<int, int> dictionary = new Dictionary<int, int>();
        public static void AddElement()
        {
            Console.WriteLine("Dodawanie elementów");
            DateTime start = DateTime.Now;
            for (int i = 0; i < max; i++)
                arraylist.Add(i);
            DateTime end = DateTime.Now;
            TimeSpan time = end - start;
            Console.WriteLine("ArrayList: " + time);

            start = DateTime.Now;
            for (int i = 0; i < max; i++)
                list.Add(i);
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("List<T>: " + time);

            start = DateTime.Now;
            for (int i = 0; i < max; i++)
                hashtable.Add(i, i);
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("Hashtable: " + time);

            start = DateTime.Now;
            for (int i = 0; i < max; i++)
                dictionary.Add(i, i);
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("Dictionary<T>: " + time);
            Console.WriteLine();
        }
        public static void LookThrough()
        {
            Console.WriteLine("Przeglądanie elementów");
            DateTime start = DateTime.Now;
            foreach (int i in arraylist) ;
            DateTime end = DateTime.Now;
            TimeSpan time = end - start;
            Console.WriteLine("ArrayList: " + time);

            start = DateTime.Now;
            foreach (int i in list) ;
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("List<T>: " + time);

            start = DateTime.Now;
            foreach (DictionaryEntry i in hashtable) ;
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("Hashtable: " + time);

            start = DateTime.Now;
            foreach (KeyValuePair<int,int> i in dictionary) ;
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("Dictionary<T>: " + time);
            Console.WriteLine();

        }

        public static void Delete()
        {
            Console.WriteLine("Usuwanie elementów");
            DateTime start = DateTime.Now;
            for (int i = 0; i < max; i++)
                arraylist.Remove(i);
            DateTime end = DateTime.Now;
            TimeSpan time = end - start;
            Console.WriteLine("ArrayList: " + time);

            start = DateTime.Now;
            for (int i = 0; i < max; i++)
                list.Remove(i);
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("List<T>: " + time);

            start = DateTime.Now;
            for (int i = 0; i < max; i++)
                hashtable.Remove(i);
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("Hashtable: " + time);

            start = DateTime.Now;
            for (int i = 0; i < max; i++)
                dictionary.Remove(i);
            end = DateTime.Now;
            time = end - start;
            Console.WriteLine("Dictionary<T>: " + time);
            Console.WriteLine();

        }
    }
}
