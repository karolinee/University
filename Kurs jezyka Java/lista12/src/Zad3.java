public class Zad3 {
    public enum ChemicalElem {
        H("Wodór", 1, 1.0079),
        He("Hel", 2, 4.0026),
        Li("Lit", 3, 6.941),
        Be("Beryl", 4, 1.0121),
        B("Bor", 5, 10.811),
        C("Węgiel", 6, 12.0107),
        N("Azot", 7, 14.0067),
        O("Tlen", 8, 15.9994),
        F("Fluor", 9, 19.9984),
        Ne("Neon", 10, 20.1797),
        Na("Sód", 11, 22.9897),
        Mg("Magnez", 12, 24.305),
        Al("Glin", 13, 26.9815),
        Si("Krzem", 14, 28.0855),
        P("Fosfor", 15, 30.9737),
        S("Siarka", 16, 32.065),
        Cl("Chlor", 17, 35.453),
        Ar("Argon", 18, 39.948);


        private final String name;
        private final int atomicNumber;
        private final double atomicWeight;

        ChemicalElem(String name, int atomicNumber, double atomicWeight){
            this.name = name;
            this.atomicNumber = atomicNumber;
            this.atomicWeight = atomicWeight;
        }

        @Override
        public String toString() {
            return super.toString() + " - " +
                    name +
                    ", liczba atomowa = " + atomicNumber +
                    ", masa atomowa = " + atomicWeight;
        }
    }

    public static void test(){
        for(ChemicalElem elem : ChemicalElem.values()){
            System.out.println(elem);
        }
    }
}
