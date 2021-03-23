import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;

public class Zad1 {
    ArrayList<Integer> data;

    public Zad1(String path){
        data = new ArrayList<>();
        System.out.println("Opening and reading file...");
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            for (String ln = br.readLine(); ln != null; ln = br.readLine()) {
                if(ln.matches("\\s*([1-9]+\\d*)*\\s*((//).*)?")){
                    ln = ln.replaceAll("\\s", ""); //usuwmy białe znaki
                    ln = ln.replaceAll("((//).*)?", ""); //usuwamy komentarze
                    if(!ln.isEmpty()){ //jeśli linia niepusta, to wstawiamy do kolekcji
                        data.add(Integer.parseInt(ln));
                    }
                }
                else throw new IllegalArgumentException("Plik niezgody ze specyfikacją");
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        }
    }

    public void test(){
        System.out.println("Sorted numbers - from biggest to smallest");
        data.stream().sorted((x1, x2) -> x2 - x1).limit(10).forEach(System.out::println);
        System.out.println("Prime numbers");
        data.stream().filter(x -> {
            if(x == 1) return false;
            if(x % 2 == 0) return false;
            for(int i = 3; i * i <= x; i += 2){
                if(x % i == 0) return false;
            }
            return true;
        }).sorted((x1, x2) -> x2 - x1).limit(10).forEach(System.out::println);

        Integer result = data.stream().filter(x -> x < 1000).reduce(0, Integer::sum);
        System.out.println("Sum of numbers less then 1000 = " + result);
        long result2 = data.stream().filter(x -> x%13 == 0).count();
        System.out.println("Number of numbers divisible by 13 = " + result2);
    }
}
