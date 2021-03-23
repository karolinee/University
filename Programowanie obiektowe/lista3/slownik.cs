using System;

namespace SlownikLibrary
{

    public class Slownik<K,V>
    {
        Element<K,V> elem;

        public V search(K key)
        {
            if(this.elem == null)
            {
                return default(V);
            }

            Element<K,V> tmp = elem;
            while(!(tmp.key.Equals(key)) && tmp.next != null)
            {
                tmp = tmp.next;
            }

            if(tmp.key.Equals(key))
            {
                return tmp.value;
            }
            else
            {
                return default(V);
            }
        }


        public void add(K key, V value)
        {
            if(this.elem == null)
            {
                this.elem = new Element<K,V>(key,value);
            }
            else
            {
                Element<K,V> tmp = elem;
                while(!(tmp.key.Equals(key)) && tmp.next != null)
                {
                    tmp = tmp.next;
                }

                if(tmp.key.Equals(key))
                {
                    tmp.value = value;
                }
                else
                {
                    Element<K,V> toAdd = new Element<K,V>(key,value);
                    tmp.next = toAdd;
                }
            }
        }
        public void remove(K key)
        {

            if(this.elem != null)
            {
                if(this.elem.key.Equals(key))
                {
                    this.elem = this.elem.next;
                }
                else
                {
                    Element<K,V> tmp = elem;
                    while(tmp.next != null && !(tmp.next.key.Equals(key)))
                    {
                        tmp = tmp.next;
                    }

                    if(tmp.next.key.Equals(key))
                    {
                        if(tmp.next.next != null)
                        {
                            tmp.next = tmp.next.next;
                        }
                        else
                        {
                            tmp.next = null;
                        }
                    }
                }

            }
        }
    }

    class Element<K,V>
    {
        public K key;
        public V value;
        public Element<K,V> next;

        public Element(K key, V value)
        {
            this.key = key;
            this.value = value;
        }
    }
}
