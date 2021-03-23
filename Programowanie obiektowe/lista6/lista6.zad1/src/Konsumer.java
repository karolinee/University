public class Konsumer implements Runnable {
    Buffer<String> buffer;
    public Konsumer(Buffer<String> buffer){
        this.buffer = buffer;
    }
    public void run()
    {
        while(true)
        {
            System.out.println(buffer.pop());
        }

    }
}
