using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad4
{
    class ListHelper
    {
        public static List<TOutput> ConvertAll<T, TOutput>(List<T> list, Converter<T, TOutput> converter)
        {
            List<TOutput> output = new List<TOutput>();
            foreach (T elem in list)
                output.Add(converter(elem));
            return output;
        }
        public static List<T> FindAll<T>(List<T> list, Predicate<T> match)
        {
            List<T> output = new List<T>();
            foreach (T elem in list)
                if (match(elem)) output.Add(elem);

            return output;
        }
        
        public static void ForEach<T>(List<T> list, Action<T> action)
        {
            foreach (T elem in list)
                action(elem);
        }
        
        public static int RemoveAll<T>(List<T> list, Predicate<T> match)
        {
            int removed = 0;
            int length = list.Count;
            for(int i = length - 1; i >= 0; i--)
            {
                if(match(list[i])) { list.RemoveAt(i); removed++; }
            }

            return removed;
        }
        
        public static void Sort<T>(List<T> list, Comparison<T> comparison)
        {
            int length = list.Count;
            
            
            for(int i = 0; i < length - 1; i++)
            {
                for(int j = 0; j < length - i -1 ; j++)
                {
                    if(comparison(list[j], list[j+1]) > 0)
                    {
                        T temp = list[j];
                        list[j] = list[j + 1];
                        list[j + 1] = temp;
                    }
                }
            }


        }

    }
}
