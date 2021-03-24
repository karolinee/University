using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad2
{
    public class Program
    {
        /// <summary>
        /// Klasa wykonująca programu 
        /// </summary>
        /// <remarks>
        /// Testowanie implemetacji siatki dwuwymiarowej
        /// </remarks>
        static void Main(string[] args)
        {
            Grid g = new Grid(3,2);

            for (int i = 0; i < 3; i++)
                for (int j = 0; j < 2; j++)
                    g[i, j] = i + j;


            
            for (int i = 0; i < 3; i++)
            {
                for (int j = 0; j < 2; j++)
                {
                    Console.Write(g[i, j]);
                }
                Console.WriteLine();
            }

            int[] dataRow = g[1];


            foreach (int elem in dataRow)
                Console.Write(elem);
            

            Console.WriteLine();

            try
            {
                g[3, 3] = 4;
            }
            catch(Exception e)
            {
                Console.WriteLine(e.Message);
            }

            Console.ReadKey();
        }
    }
}
