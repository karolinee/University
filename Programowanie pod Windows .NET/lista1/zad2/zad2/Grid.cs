using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad2
{
    /// <summary>
    /// Klasa siatki dwuwymiarowej zawierająca indeksery
    /// </summary>
    class Grid
    {
        private int[,] _grid;
        private readonly int rows;
        private readonly int columns;

        /// <summary>
        /// Konstruktor klasy
        /// </summary>
        /// <param name="x">Ilość wierszy</param>
        /// <param name="y">Ilość kolumn</param>
        public Grid(int x, int y)
        {
            _grid = new int[x, y];
            rows = x;
            columns = y;
        }

        /// <summary>
        /// Indekser jednowymiarowy
        /// </summary>
        /// <param name="i">Numer wiersza</param>
        /// <returns>Zadany wiersz siatki</returns>
        /// <remarks>Zawiera jednynie get</remarks>
        public int[] this[int i]
        {
            get
            {
                if (i < 0 || i >= rows) throw new IndexOutOfRangeException();

                int[] temp = new int[columns];
                Buffer.BlockCopy(_grid, sizeof(int) * columns * i, temp, 0, sizeof(int) * columns);
                return temp;
            }
        }

        /// <summary>
        /// Indekser jednowymiarowy
        /// </summary>
        /// <param name="i">Numer wiersza</param>
        /// <param name="j">Numer kolumny</param>
        /// <returns>Zadaną wartość z siatki</returns>
        public int this[int i, int j]
        {
            get
            {
                if (i < 0 || i >= rows || j < 0 || j >= columns) throw new IndexOutOfRangeException();
                return _grid[i, j];
            }
            set
            {
                if (i < 0 || i >= rows || j < 0 || j >= columns) throw new IndexOutOfRangeException();
                _grid[i, j] = value;
            }
        }
    }
}
