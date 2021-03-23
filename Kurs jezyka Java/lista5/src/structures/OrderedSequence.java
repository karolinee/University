package structures;

public interface OrderedSequence<T extends  Comparable<T>> extends Iterable<T> {
    public void insert (T elem) throws Exception;
    public void remove (T elem) throws Exception;
    public T min() throws Exception;
    public T max() throws Exception;
    public T at(int pos) throws Exception;
    public boolean search(T elem) throws Exception;
    public int index(T elem) throws Exception;
}
