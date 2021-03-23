import com.sun.tools.jconsole.JConsoleContext;

import java.io.BufferedReader;
import java.io.Console;
import java.io.FileReader;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.NoSuchElementException;

public class Zad2 {
    LinkedList<Triangle> data;
    public Zad2(String path){
        data = new LinkedList<>();
        System.out.println("Opening and reading file...");
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            for (String ln = br.readLine(); ln != null; ln = br.readLine()) {
                if(ln.matches("\\s*(((\\d+(\\.\\d+)*)\\s+){2}(\\d+(\\.\\d+)*)\\s*)?((//).*)?")){
                    ln = ln.replaceAll("((//).*)?", ""); //usuwamy komentarz
                    ln = ln.replaceAll("\\s+", " "); //białe znaki zastępujemy pojedynczą spacją
                    ln = ln.trim(); //usuwamy spacje z początku i końca
                    if(!ln.isEmpty()){ //jak niepustyto dzielimy na podstawie spacji na 3 elementy (3 liczby)
                        String[] numbers = ln.split(" ");
                        Triangle t = null;
                        try{
                            t = new Triangle(Double.parseDouble(numbers[0]), Double.parseDouble(numbers[1]), Double.parseDouble(numbers[2]));
                        } catch (Exception e) {
                            System.out.println(e.getMessage() + " " + ln);
                        }
                        if(t != null){
                            data.add(t);
                        }

                    }
                }
                else throw new IllegalArgumentException("Plik niezgody ze specyfikacją");
            }
        }
        catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

    }

    public void test(){
        System.out.println("Sorted triangles by perimeter - from smallest to biggest");
        data.stream().sorted(Comparator.comparingDouble(Triangle::perimeter)).limit(10).forEach(System.out::println);
        System.out.println("Right triangles");
        data.stream().filter(t1 -> {
            double x = t1.getX();
            double y = t1.getY();
            double z = t1.getZ();
            x *= x;
            y *= y;
            z *= z;
            return (x + y == z || x + z == y || y + z == x);
        }).forEach(System.out::println);

        long res = data.stream().filter(t -> Double.compare(t.getX(),t.getY()) == 0 && Double.compare(t.getX(),t.getZ()) == 0).count();
        System.out.println("Number of regular triangles = " + res);

        Triangle max = data.stream().max(Comparator.comparingDouble(Triangle::area)).orElseThrow(NoSuchElementException::new);
        Triangle min = data.stream().min(Comparator.comparingDouble(Triangle::area)).orElseThrow(NoSuchElementException::new);
        System.out.println("Triangle with biggest area " + max);
        System.out.println("Triangle with smallest area " + min);
    }

    private static class Triangle{
        private final double x, y, z;
        public Triangle(double x, double y, double z){
            if(!(Double.compare((x + y), z) == 1 && Double.compare((x + z), y) == 1 && Double.compare((z + y), x) == 1 )) throw new IllegalArgumentException("Nie można zbudować trójkąta z podanych długości boków");
            this.x = x;
            this.y = y;
            this.z = z;
        }

        public double getX() {
            return x;
        }

        public double getY() {
            return y;
        }

        public double getZ() {
            return z;
        }

        public double perimeter(){
            return x + y + z;
        }

        public double area(){
            double p = perimeter()/2;
            return Math.sqrt(p*(p-x)*(p-y)*(p-z));
        }

        @Override
        public String toString() {
            return x + " " + y + " " + z;
        }
    }
}
