using System;
using System.Collections;

namespace zad2
{
    public interface Numbers
    {
        bool eos();
        int next();
        void reset();
    }
    class IntStream : Numbers, IEnumerable
    {
        int number = 0;
        bool end = false;

        public int next()
        {
            if(number == Int32.MaxValue)
            {
                end = true;
                return number;
            }
            else
            {
                return number++;
            }
        }

        public void reset()
        {
            number = 0;
            end = false;
        }

        public bool eos()
        {
            return end;
        }

        public override string ToString()
        {
            return String.Format("Liczba {0}",number);
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return (IEnumerator) GetEnumerator();
        }

        public IntEnum GetEnumerator()
        {
            return new IntEnum();
        }
    }

    public class IntEnum : IEnumerator
    {

        int i = 0;

        public bool MoveNext()
        {
            i++;
            return(i < 100);
        }

        public void Reset()
        {
            i = -1;
        }

        public object Current
        {
            get
            {
                return i;
            }
        }
    }

    class PrimeStream : Numbers
    {
        int number = 0;
        bool end = false;
        private bool isPrime()
        {
            if(number <= 1) return false;
            if(number == 2) return true;
            if(number % 2 == 0) return false;

            for(int i = 3; i <= (int)Math.Floor(Math.Sqrt(number)) ; i++)
            {
                if(number % i == 0) return false;
            }
            return true;
        }
        private void prime()
        {
            while(number < Int32.MaxValue && !isPrime())
            {
                number++;
            }
        }
        public int next()
        {
            if(number == Int32.MaxValue)
            {
                end = true;
                return number;
            }
            else
            {
                prime();
                if((number == Int32.MaxValue))
                    return number;
                else
                {
                    return number++;
                }
            }
        }
        public void reset()
        {
            number = 0;
            end = false;
        }

        public bool eos()
        {
            return end;
        }

        private bool isPrime2(int num)
        {
            if(num <= 1) return false;
            if(num == 2) return true;
            if(num % 2 == 0) return false;

            for(int i = 3; i <= (int)Math.Floor(Math.Sqrt(num)) ; i++)
            {
                if(num % i == 0) return false;
            }
            return true;
        }
        public int this[int index]
        {
            get
            {

                int pr = 2;

                for(; index > 1; index--)
                {
                    pr++;
                    while((pr < Int32.MaxValue) && (!isPrime2(pr)))
                        pr++;
                }

                return pr;

            }
        }

        public int Length
        {
            get
            {
                return (int)Math.Floor(Math.Log10(number)) + 1;
            }
        }
      }


    class Program
    {
        static void Main(string[] args)
        {
            IntStream i = new IntStream();

            PrimeStream p = new PrimeStream();

            foreach(int q in i)
                Console.WriteLine(q);

            Console.WriteLine(i);
            i.next();
            Console.WriteLine(i);

            Console.WriteLine(p.next());
            Console.WriteLine(p.Length);
            Console.WriteLine(p.next());
            Console.WriteLine(p.Length);
            Console.WriteLine(p.next());
            Console.WriteLine(p.Length);
            Console.WriteLine(p.next());
            Console.WriteLine(p.Length);
            Console.WriteLine(p.next());
            Console.WriteLine(p.Length);
            Console.WriteLine("TESTY PRIME");
            Console.WriteLine(p[1]);
            Console.WriteLine(p[2]);
            Console.WriteLine(p[10]);
            Console.WriteLine(p[5]);
        }
    }
}
