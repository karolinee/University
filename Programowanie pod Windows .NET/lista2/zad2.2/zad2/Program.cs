using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad2
{
    class Program
    {
        static void Main(string[] args)
        {
            //drzewo jak z wykładu s.165
            /*
                    1 
                   / \
                  2   4
                   \ / \
                   3 5  6  
            */

            BinaryTreeNode<int> tree = new BinaryTreeNode<int>
            {
                Value = 1,
                Left = new BinaryTreeNode<int>
                {
                    Value = 2,
                    Right = new BinaryTreeNode<int> { Value = 3 }
                },
                Right = new BinaryTreeNode<int>
                {
                    Value = 4,
                    Left = new BinaryTreeNode<int> { Value = 5 },
                    Right = new BinaryTreeNode<int> { Value = 6 }
                }
            };

            Console.WriteLine("BFS bez yield: ");
            foreach (var value in tree)
                Console.Write(value + " ");

            Console.WriteLine("\nDFS bez yield: ");
            var DFSenum = tree.GetEnumeratorDFS();
            while (DFSenum.MoveNext())
                Console.Write(DFSenum.Current + " ");

            Console.WriteLine("\nBFS z yield: ");
            var BFSenumyiel = tree.GetEnumeratorBFSyield();
            while (BFSenumyiel.MoveNext())
                Console.Write(BFSenumyiel.Current + " ");

            Console.WriteLine("\nDFS z yield: ");
            var DFSenumyiel = tree.GetEnumeratorDFSyield();
            while (DFSenumyiel.MoveNext())
                Console.Write(DFSenumyiel.Current + " ");

            Console.ReadKey();
        }
    }
}
