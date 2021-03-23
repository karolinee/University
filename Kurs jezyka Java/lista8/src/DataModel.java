import javax.swing.*;
import java.util.*;
import java.util.Date;

public class DataModel extends AbstractListModel {
    static public final String[] monthToString = {"Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"};
    static public final String[] dayToString = {"Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota", "Niedziela"};
    static public final String[] dayToStringShort = {"pn", "wt", "śr", "czw", "pt", "sb", "nd"};
    static public final int[] monthToDay = {31,28,31,30,31,30,31,31,30,31,30,31};


    private int month;
    private int year;

    public DataModel(int year, int month){
        this.month = month;
        this.year = year;
    }

    public void setYear(int year){
        this.year = year;
        fireContentsChanged(this, 0, getSize()-1);
    }

    public void setMonth(int month){
        this.month = month;
        fireContentsChanged(this, 0, getSize()-1);
    }

    public void change(int year, int month){
        setYear(year);
        setMonth(month);
    }

    @Override
    public int getSize() {
        if(year == 1582 && month == 9) return 21;
        if(month == 1 && ((year % 400 == 0) || (year % 4 == 0 && year % 100 != 0) || (year <= 1582 && year % 4 == 0))) return 29;
        return monthToDay[month];
    }

    private int dayOfWeek(int i){
        GregorianCalendar calendar = new GregorianCalendar(year, month, i + 1);
        int w = calendar.get(GregorianCalendar.DAY_OF_WEEK);
        return (w == 1) ? 6 : w - 2 ;
    }
    @Override
    public Object getElementAt(int i) {
        int k = 0;
        if(year == 1582 && month == 9 && i >= 4) k = 10;
        return dayToString[dayOfWeek(i + k)] + " "  + (i + 1 + k) + " " + monthToString[month];
    }

    public int getWeekdayNumber(int i){
        return dayOfWeek(i);
    }
}
