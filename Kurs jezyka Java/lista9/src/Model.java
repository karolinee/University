import java.math.BigInteger;

public class Model {

    public String eval(String arg1, String op, String arg2, int numSys){
        BigInteger a1 = new BigInteger(arg1, numSys);
        BigInteger a2 = new BigInteger(arg2, numSys);
        switch (op){
            case "+":
                return a1.add(a2).toString(numSys);
            case "-":
                return a1.subtract(a2).toString(numSys);
            case "*":
                return a1.multiply(a2).toString(numSys);
            case "/":
                if(a2.compareTo(BigInteger.ZERO) == 0) return "ERROR";
                return a1.divide(a2).toString(numSys);
            case "%":
                if(a2.compareTo(BigInteger.ZERO) == 0) return "ERROR";
                return a1.remainder(a2).toString(numSys);
            case "()":
                if(a2.compareTo(BigInteger.ZERO) < 0) return "ERROR";
                if(a1.compareTo(a2) < 0) return "ERROR";
                return binomi(a1, a2).toString(numSys);
            case "^":
                if(a2.compareTo(BigInteger.ZERO) < 0) return BigInteger.ZERO.toString();
                return a1.pow(a2.intValue()).toString(numSys);
            default:
                return "ERROR";
        }
    }

    public String eval(String arg1, String op, int numSys){
        BigInteger a1 = new BigInteger(arg1, numSys);
        switch (op){
            case "!":
                if(a1.compareTo(BigInteger.ZERO) < 0) return "ERROR";
                return fact(a1).toString(numSys);
            default:
                return "ERROR";
        }
    }

    private BigInteger fact(BigInteger arg){
        if(arg.equals(BigInteger.ZERO)){
            return BigInteger.ONE;
        }
        else{
            return arg.multiply(fact(arg.subtract(BigInteger.ONE)));
        }
    }
    private BigInteger binomi(BigInteger n, BigInteger k) {
        if ((n.equals(k)) || k.equals(BigInteger.ZERO)){
            return BigInteger.ONE;
        }
        else{
            return fact(n).divide(fact(k).multiply(fact(n.subtract(k))));
        }

    }

}
