public class Main {
    public static void main(String[] args)
    {
        Buffer<String> buffer = new Buffer<>(10);

        Producent producent = new Producent(buffer);
        Konsumer konsumer = new Konsumer(buffer);

        Thread watek1 = new Thread(producent);
        Thread watek2 = new Thread(konsumer);

        watek1.start();
        watek2.start();

    }
}
