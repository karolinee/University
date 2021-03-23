public class Producent implements Runnable {
    Buffer<String> buffer;
    public Producent(Buffer<String> buffer){
        this.buffer = buffer;
    }
    public void run()
    {
        while(true)
        {
            buffer.push("a");
        }

    }
}
