using System;
using System.Collections;

namespace zad2
{
    public class PrimeCollection: IEnumerable
    {
        IEnumerator IEnumerable.GetEnumerator()
        {
            return (IEnumerator) GetEnumerator();
        }

        public PrimeEnum GetEnumerator()
        {
            return new PrimeEnum();
        }
    }

    public class PrimeEnum : IEnumerator
    {

        int prime = 1;


        public bool MoveNext()
        {
            int i = prime;
            bool contin = true;

            while(contin)
            {
                i++;
                contin = false;

                for(int j = 2; j*j <= i && !contin; j++)
                {
                    if(i % j == 0)
                    {
                        contin = true;
                    }
                }


            }

            prime = i;

            return prime < 100;
        }

        public void Reset()
        {
            prime = 1;
        }

        public object Current
        {
            get
            {
                return this.prime;
            }
        }




}
    class Program
    {
        static void Main(string[] args)
        {
            PrimeCollection pc = new PrimeCollection();
            foreach(int p in pc)
                Console.WriteLine(p);
        }
    }
}
