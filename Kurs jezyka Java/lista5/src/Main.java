import structures.OrderedList;
import structures.OrderedSequence;

import java.util.Calendar;
import java.util.Iterator;


public class Main {
    public static void testInt() throws Exception {
        System.out.println("---------TEST NA INTEGER");
        OrderedSequence<Integer> intSeq = new OrderedList<Integer>();
        intSeq.insert(1);
        intSeq.insert(5);
        intSeq.insert(7);
        intSeq.insert(3);
        intSeq.insert(-5);
        System.out.println("Wstawiamy elementy 1, 5, 7, 3, -5 -> " + intSeq);

        intSeq.remove(3);
        intSeq.remove(7);
        intSeq.remove(-5);
        System.out.println("Usuwamy elementy 3, 7, -5 -> " + intSeq);

        intSeq.insert(5);
        intSeq.insert(10);
        intSeq.insert(-2);
        System.out.println("Wstawiamy dodatkowo elementy 5, 10, -2 -> " + intSeq);

        System.out.println("min = " + intSeq.min());
        System.out.println("max = " + intSeq.max());

        System.out.println("Szukamy elementów -2, 5, 4 i sprawdzamy czy elem == at(index(elem))");
        if(intSeq.search(-2)) {
            int idx = intSeq.index(-2);
            System.out.println("2 is at position = " + idx + " at idx " + idx + " is = " + intSeq.at(idx));
        }
        if(intSeq.search(5)) {
            int idx = intSeq.index(5);
            System.out.println("5 is at position = " + idx + " at idx " + idx + " is = " + intSeq.at(idx));
        }
        if(intSeq.search(4)) {
            int idx = intSeq.index(4);
            System.out.println("4 is at position = " + idx + " at idx " + idx + " is = " + intSeq.at(idx));
        }


        System.out.println("Iterowanie po kolekcji pętą for-each");
        for(int i : intSeq){
            System.out.print(i + " ");
        }
        System.out.println();

        System.out.println("Usunięcie elementu równego 1 za pomocą iteratora");
        Iterator<Integer> it = intSeq.iterator();
        while (it.hasNext()){
            int i = it.next();
            if(i == 1){
                it.remove();
            }
        }

        System.out.println("Sprawdzenie toString");
        System.out.println(intSeq);

    }
    public static void testString() throws Exception {
        System.out.println("---------TEST NA STRING");
        OrderedSequence<String> stringSeq = new OrderedList<>();
        stringSeq.insert("b");
        stringSeq.insert("a");
        stringSeq.insert("aa");
        stringSeq.insert("zz");
        stringSeq.insert("z");
        System.out.println("Wstawiamy elementy b, a, aa, zz, z -> " + stringSeq);

        stringSeq.remove("a");
        stringSeq.remove("zz");
        stringSeq.remove("b");
        System.out.println("Usuwamy elementy a, zz, b -> " + stringSeq);

        stringSeq.insert("ab");
        stringSeq.insert("a");
        stringSeq.insert("z");
        System.out.println("Wstawiamy dodatkowo elementy ab, a, z -> " + stringSeq);

        System.out.println("min = " + stringSeq.min());
        System.out.println("max = " + stringSeq.max());

        System.out.println("Szukamy elementów a, ab, kk i sprawdzamy czy elem == at(index(elem))");
        if(stringSeq.search("a")) {
            int idx = stringSeq.index("a");
            System.out.println("a is at position = " + idx + " at idx " + idx + " is = " + stringSeq.at(idx));
        }
        if(stringSeq.search("ab")) {
            int idx = stringSeq.index("ab");
            System.out.println("ab is at position = " + idx + " at idx " + idx + " is = " + stringSeq.at(idx));
        }
        if(stringSeq.search("kk")) {
            int idx = stringSeq.index("kk");
            System.out.println("kk is at position = " + idx + " at idx " + idx + " is = " + stringSeq.at(idx));
        }

        System.out.println("Iterowanie po kolekcji pętą for-each");
        for(String i : stringSeq){
            System.out.print(i + " ");
        }
        System.out.println();

        System.out.println("Usunięcie elementu równego z za pomocą iteratora");
        Iterator<String> it = stringSeq.iterator();
        while (it.hasNext()){
            if(it.next() == "z"){
                it.remove();
            }
        }

        System.out.println("Sprawdzenie toString");
        System.out.println(stringSeq);
    }
    public static void testCalendar() throws Exception {
        System.out.println("---------TEST NA CALENDAR");
        OrderedSequence<Calendar> calendarSeq = new OrderedList<>();
        Calendar c = Calendar.getInstance();
        calendarSeq.insert(c);
        Calendar c1 = Calendar.getInstance();
        c1.set(Calendar.MONTH, Calendar.SEPTEMBER);
        calendarSeq.insert(c1);
        Calendar c2 = Calendar.getInstance();
        c2.set(Calendar.MONTH, Calendar.DECEMBER);
        calendarSeq.insert(c2);
        for(Calendar i : calendarSeq){
            System.out.println(i.getTime());
        }
        System.out.println();

        calendarSeq.remove(c2);
        Calendar c3 = Calendar.getInstance();
        c3.set(1999, 2, 2, 10,10, 10);
        calendarSeq.insert(c3);
        Calendar c4 = Calendar.getInstance();
        c4.set(1999, 2, 2, 10,10, 10);
        calendarSeq.insert(c4);
        for(Calendar i : calendarSeq){
            System.out.println(i.getTime());
        }
        System.out.println();


        System.out.println("min = " + calendarSeq.min().getTime());
        System.out.println("max = " + calendarSeq.max().getTime());


        System.out.println("Szukamy elementów a, ab, kk i sprawdzamy czy elem == at(index(elem))");
        if(calendarSeq.search(c3)) {
            int idx = calendarSeq.index(c3);
            System.out.println("c4 is at position = " + idx + " at idx " + idx + " is = " + calendarSeq.at(idx).getTime());
        }

        System.out.println("Usunięcie elementu równego z za pomocą iteratora");
        Iterator<Calendar> it = calendarSeq.iterator();
        while (it.hasNext()){
            if(it.next().compareTo(c4) == 0){
                it.remove();
            }
        }

        for(Calendar i : calendarSeq){
            System.out.println(i.getTime());
        }
        System.out.println();


    }
    public static void main(String[] args) throws Exception {
        testInt();
        testString();
        testCalendar();

    }
}