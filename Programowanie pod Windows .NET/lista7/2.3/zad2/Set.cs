using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad2
{
    //użycie Queue ponieważ Set nie potrzebuje dostępu indeksowanego (jak inne kolekcje), tylko przeglądanie elementów (dość oczywiste, że w kolejności w jakiej dodajemy)
    class Set : Queue
    {
        public void Add(object value)
        {
            Enqueue(value);
        }
        public override void Enqueue(object obj)
        {
            if (!Contains(obj)) base.Enqueue(obj);
        }
        public void Remove(object value)
        {
            if(Contains(value))
            {
                while(true)
                {
                    object tmp = Dequeue();
                    if (tmp.Equals(value)) break;
                    Enqueue(tmp);
                }
            }
        }
    }
}
