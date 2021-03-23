package structures;

import java.util.Iterator;

public class OrderedList<T extends Comparable<T>> implements OrderedSequence<T>{
    private class OrderListIterator implements Iterator<T> {
        Node<T> prev;
        Node<T> curr;
        Node<T> next;
        boolean removed;

        public OrderListIterator(){
            next = start;
            removed = true; //nie możemy usunąć zanim wywołamy next()
        }
        @Override
        public boolean hasNext() {
            return next != null;
        }

        @Override
        public T next() {
            if(!hasNext()) throw new IllegalArgumentException("cant move to next");
            T data = next.data;
            prev = curr;
            curr = next;
            next = next.next;
            removed = false;
            return data;
        }

        @Override
        public void remove() {
            if(removed) throw new IllegalArgumentException("cant remove");
            if(prev == null) {
                start = next;
                curr = null;
            }
            else {
                prev.next = next;
                curr = prev;
            }
            removed = true;
        }
    }

    private class Node<T extends Comparable<T>>{
        private Node<T> next;
        private final T data;

        public Node(T data){
            this.data = data;
            this.next = null;
        }

        public void insert(T elem) {
            //wiemy że element do wstawienie jest większy od nas
            if(next == null) {
                next = new Node<>(elem);
            }
            else {
                T nextData = next.data;
                int compareResNext = nextData.compareTo(elem);
                if (compareResNext < 0) next.insert(elem);
                else if(compareResNext > 0) {
                    Node<T> current = new Node<>(elem);
                    current.next = next;
                    next = current;
                }
            }
        }

        public  void remove(T elem) {
            //wiemy że element do usunięcia jest większy od nas
            if(next != null) {
                T nextData = next.data;
                int compareResNext = nextData.compareTo(elem);
                if (compareResNext < 0) next.remove(elem);
                else if(compareResNext == 0) {
                    next = next.next;
                }
            }
        }

        public T lastValue(){
            if(next == null) return data;
            return next.lastValue();
        }

        public T valueAt(int pos) {
            if(pos == 0) return data;
            if(this.next != null) return next.valueAt(pos - 1);
            throw new IndexOutOfBoundsException("index out of bounds");
        }

        public boolean search(T elem){
            int compareRes = data.compareTo(elem);
            if(compareRes == 0) return true;
            if(compareRes > 0 || next == null) return false;
            return next.search(elem);
        }

        public int index(T elem, int idx){
            int compareRes = data.compareTo(elem);
            if(compareRes == 0) return idx;
            if(compareRes > 0 || next == null) throw new IllegalArgumentException("this element does not exist");
            return next.index(elem, idx + 1);
        }

        @Override
        public String toString () {
            if (next != null) return data.toString() + " " + next.toString();
            else return data.toString();
        }
    }

    private Node<T> start;

    @Override
    public void insert(T elem) throws Exception{
        if(elem == null) throw new NullPointerException("element to insert cant be null");
        if(start == null) {
            start = new Node<>(elem);
        }
        else{
            T startVal = start.data;
            int compareRes = startVal.compareTo(elem);
            if(compareRes > 0) {
                Node<T> newStart = new Node<>(elem);
                newStart.next = start;
                start = newStart;
            }
            else if (compareRes < 0){
                start.insert(elem);
            }
        }
    }

    @Override
    public void remove(T elem) throws Exception {
        if(elem == null) throw new NullPointerException("element to remove cant be null");
        if(start == null) throw new Exception("sequence is empty");
        T startVal = start.data;
        int compareRes = startVal.compareTo(elem);
        if(compareRes == 0) {
            start = start.next;
        }
        else if (compareRes < 0){
            start.remove(elem);
        }
    }

    @Override
    public T min() throws Exception {
        if(start == null) throw new Exception("sequence is empty");
        return start.data;
    }

    @Override
    public T max() throws Exception {
        if (start == null) throw new Exception("sequence is empty");
        return start.lastValue();
    }

    @Override
    public T at(int pos) throws Exception {
        if (pos < 0) throw new IndexOutOfBoundsException("index cant be negative");
        if (start == null) throw new Exception("sequence is empty");
        return start.valueAt(pos);
    }

    @Override
    public boolean search(T elem) throws Exception {
        if(elem == null) throw new NullPointerException("element to search cant be null");
        if(start == null) throw new Exception("sequence is empty");
        return start.search(elem);
    }

    @Override
    public int index(T elem) throws Exception {
        if(elem == null) throw new NullPointerException("element to search index cant be null");
        if(start == null) throw new Exception("sequence is empty");
        return start.index(elem, 0);
    }

    @Override
    public Iterator<T> iterator() {
        return new OrderListIterator();
    }

    @Override
    public String toString () {
        if (start == null) return "";
        return start.toString();
    }
}
