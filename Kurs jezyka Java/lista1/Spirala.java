
public class Spirala
{
    public static boolean isPrime(int n)
    {
        if (n < 2) return false;
        if (n % 2 == 0) return (n == 2);

        int root = (int)Math.sqrt(n);
        for(int i = 3; i <= root; i+=2){
            if(n % i == 0) return false;
        }

        return true;
    }

    public static void createUlamSpiral(int n, int[][] spiral){
        int x = n/2;
        int y = n/2;

        int dx = 0;
        int dy = 1;

        boolean even = false;
        if(n % 2 == 0){
            y--;
            even = true;
            dx = 1;
            dy = 0;
        }
    
        int number = 1;
        while(number <= n*n){
            spiral[x][y] = number;
            number++;
            if((even && ((x < n/2 && y < n/2 && x - 1 == y) || (!(x < n/2 && y < n/2) && (x == y || x+y == n-1)))) ||
            (!even && ((x >= n/2 && y >= n/2 && x + 1 == y) || (!(x >= n/2 && y >= n/2) && (x == y || x+y == n-1))))){
                int temp = dx;
                dx = -dy;
                dy = temp;
            }
            x += dx;
            y += dy;
        }

    }

    public static void removeNotPrimes(int n, int[][] spiral){
        for(int i = 0; i < n; i++){
            for(int j = 0; j < n; j++){
                if(!isPrime(spiral[i][j])){
                    spiral[i][j]=0;
                }
            }
        }
    }

    public static void printSpiral(int n, int[][] spiral){
        for(int i = 0; i < n; i++){
            for(int j = 0; j < n; j++){
                if(spiral[i][j] == 0){
                    System.out.print(" ");
                }
                else{
                    System.out.print("*");
                }
            }
            System.out.println();
        }
    }

    public static void main (String[] args) throws Exception
    {
        if(args.length != 1) throw new IllegalArgumentException("podaj jeden argument");

        int n = Integer.valueOf(args[0]);

        if(n < 2 || n > 200) throw new IllegalArgumentException("parametr spoza zakresu 2...200");

        int[][] spiral = new int[n][n];

        createUlamSpiral(n, spiral);
        removeNotPrimes(n, spiral);
        printSpiral(n, spiral);       
    }
}
