using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad2
{
    class BinaryTreeNode<T> : IEnumerable<T>
    {
        public T Value { get; set; }
        public BinaryTreeNode<T> Left { get; set; }
        public BinaryTreeNode<T> Right { get; set; }

        public IEnumerator<T> GetEnumerator()
        {
            return GetEnumeratorBFS();
        }
        IEnumerator IEnumerable.GetEnumerator()
        {
            return this.GetEnumerator();
        }

        public IEnumerator<T> GetEnumeratorBFS()
        {
            return new EnumeratorBFS(this);
        }
        public IEnumerator<T> GetEnumeratorDFS()
        {
            return new EnumeratorDFS(this);
        }
        public IEnumerator<T> GetEnumeratorBFSyield()
        {
            Queue < BinaryTreeNode < T >> queue = new Queue<BinaryTreeNode<T>>();
            queue.Enqueue(this);
            while(queue.Any())
            {
                BinaryTreeNode < T > curr = queue.Dequeue();
                if (curr.Left != null)
                    queue.Enqueue(curr.Left);
                if (curr.Right != null)
                    queue.Enqueue(curr.Right);
                yield return curr.Value;
            }

        }
        public IEnumerator<T> GetEnumeratorDFSyield()
        {
            yield return Value;

            if (Left != null)
                foreach (var elem in Left)
                    yield return elem;
            if (Right != null)
                foreach (var elem in Right)
                    yield return elem;
        }





        private class EnumeratorBFS : IEnumerator<T>
        {
            private Queue<BinaryTreeNode<T>> queue = new Queue<BinaryTreeNode<T>>();
            private BinaryTreeNode<T> root;
            private BinaryTreeNode<T> curr;

            public EnumeratorBFS(BinaryTreeNode<T> tree)
            {
                root = tree;
                this.Reset();    
            }

            public T Current
            {
                get
                {
                    if (curr != null)
                        return curr.Value;
                    else
                        throw new ArgumentException("Brak elementu do zwrócenia wartosci");
                }
            }

            object IEnumerator.Current
            {
                get
                {
                    return Current;
                }
            }

            public void Dispose() { }

            public bool MoveNext()
            {
                if(queue.Count > 0)
                {
                    curr = queue.Dequeue();
                    if (curr.Left != null) queue.Enqueue(curr.Left);
                    if (curr.Right != null) queue.Enqueue(curr.Right);
                    return true;
                }
                return false;
            }

            public void Reset()
            {
                queue.Clear();
                queue.Enqueue(root);
                curr = root;
            }
        }

        private class EnumeratorDFS : IEnumerator<T>
        {
            private Stack<BinaryTreeNode<T>> stack = new Stack<BinaryTreeNode<T>>();
            private BinaryTreeNode<T> root;
            private BinaryTreeNode<T> curr;

            public EnumeratorDFS(BinaryTreeNode<T> tree)
            {
                root = tree;
                this.Reset();
            }

            public T Current
            {
                get
                {
                    if (curr != null)
                        return curr.Value;
                    else
                        throw new ArgumentException("Brak elementu do zwrócenia wartosci");
                }
            }

            object IEnumerator.Current
            {
                get
                {
                    return Current;
                }
            }

            public void Dispose() { }

            public bool MoveNext()
            {
                if (stack.Count > 0)
                {
                    curr = stack.Pop();
                    if (curr.Left != null) stack.Push(curr.Left);
                    if (curr.Right != null) stack.Push(curr.Right);
                    return true;
                }
                return false;
            }

            public void Reset()
            {
                stack.Clear();
                stack.Push(root);
                curr = root;
            }
        }



    }
}
