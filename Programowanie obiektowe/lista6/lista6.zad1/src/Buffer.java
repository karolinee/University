public class Buffer<T> {
    T[] buffer;

    int size, howMany, head;


    public Buffer(int size)
    {
        buffer = (T[])new Object[size];

        howMany = 0;


        head = 0;

        this.size = size;
    }

    public synchronized void push(T val)
    {
        while(howMany == size)
        {
            try
            {
                System.out.println("Buffer is full!");
                wait();
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }
        buffer[(howMany + head) % size] = val;

        howMany++;

        notifyAll();
    }
    public synchronized T pop()
    {
        while(howMany == 0)
        {
            try
            {
                System.out.println("Buffer is empty!");
                wait();
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }

        T temp = buffer[(howMany + head - 1) % size];

        head = (head + 1) % size;

        howMany--;

        notifyAll();

        return temp;
    }

}
