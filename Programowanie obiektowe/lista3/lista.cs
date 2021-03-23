using System;

namespace List
{

    public class Lista<T>
    {
        Element<T> first;
        Element<T> last;

        public void addBeg(T val)
        {
            if(this.isEmpty())
            {
                this.first = new Element<T>(val);
                this.last = this.first;
            }
            else
            {
                Element<T> tmp = new Element<T>(val);
                tmp.next = this.first;
                this.first.prev = tmp;
                this.first = tmp;
            }

        }
        public void addEnd(T val)
        {
            if(this.isEmpty())
            {
                this.first = new Element<T>(val);
                this.last = this.first;
            }
            else
            {
                Element<T> tmp = new Element<T>(val);
                tmp.prev = this.last;
                this.last.next = tmp;
                this.last = tmp;
            }
        }

        public T removeBeg()
        {
            if(this.isEmpty())
            {
                return default(T);
            }

            Element<T> tmp = this.first;

            if(this.first.next != null)
            {
                this.first.next.prev = null;
                this.first = this.first.next;
            }
            else
            {
                this.first = null;
                this.last = null;
            }

            return tmp.value;

        }
        public T removeEnd()
        {
            if(this.isEmpty())
            {
                return default(T);
            }

            Element<T> tmp = this.last;

            if(this.last.prev != null)
            {
                this.last.prev.next = null;
                this.last = this.last.prev;
            }
            else
            {
                this.first = null;
                this.last = null;
            }

            return tmp.value;
        }

        public bool isEmpty()
        {
            if(this.first == null && this.last == null)
                return true;

            return false;
        }
    }

    class Element<T>
    {
        public T value;
        public Element<T> next;
        public Element<T> prev;

        public Element(T value)
        {
            this.value = value;
        }
    }
}
