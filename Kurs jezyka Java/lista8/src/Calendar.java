import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.util.GregorianCalendar;

public class Calendar extends JFrame {
    private JTabbedPane tp;

    private ArrayList<MonthPanel> months;
    private ArrayList<MonthPanelList> monthsList;

    private JSpinner yearChoice;
    private JScrollBar monthChoice;

    private int year;
    private int month;
    public Calendar(){
        super("Kalendarz");

        GregorianCalendar calendar = new GregorianCalendar();
        this.month = calendar.get(java.util.Calendar.MONTH);
        this.year = calendar.get(java.util.Calendar.YEAR);

        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setSize(800,800);

        makeTabbedPane();
        makeToolBar();

        setVisible(true);
    }

    private void makeTabbedPane(){
        tp = new JTabbedPane();

        JPanel yearPanel = new JPanel();
        yearPanel.setLayout(new GridLayout(4, 3));
        months = new ArrayList<>();
        for(int i = 0; i < 12; i++){
            MonthPanel mp = new MonthPanel(year, i);
            mp.addMouseListener(new MouseAdapter() {
                @Override
                public void mouseClicked(MouseEvent e) {
                    MonthPanel mp = (MonthPanel) e.getSource();
                    changeMonth(mp.month);
                }
            });
            yearPanel.add(mp);
            months.add(mp);
        }


        JPanel monthPanel = new JPanel();
        monthPanel.setLayout(new GridLayout(1, 3));
        monthsList = new ArrayList<>();
        int[] y = {(month == 0) ? year - 1 : year, year, (month == 11) ? year + 1 : year};
        int[] m = {(month == 0) ? 11 : month - 1, month, (month == 11) ? 0 : month + 1};
        for(int i = 0; i < 3; i++){
            MonthPanelList mpl = new MonthPanelList(y[i], m[i]);
            monthPanel.add(mpl);
            monthsList.add(mpl);
        }

        tp.addTab(String.valueOf(year), yearPanel);
        tp.addTab(DataModel.monthToString[month], monthPanel);
        add(tp, BorderLayout.CENTER);
    }
    private void makeToolBar(){
        JToolBar tb = new JToolBar();

        JLabel y = new JLabel("Rok: ");
        tb.add(y);
        JButton prevYear = new JButton("<");
        prevYear.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                changYear(year-1);
            }
        });
        tb.add(prevYear);

        JButton nextYear = new JButton(">");
        nextYear.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                changYear(year+1);
            }
        });
        tb.add(nextYear);

        yearChoice = new JSpinner(new SpinnerNumberModel(year, 0, 2100, 1));
        yearChoice.setEditor(new JSpinner.NumberEditor(yearChoice, "#"));
        yearChoice.addChangeListener(e -> {
            int i = (int)yearChoice.getValue();
            changYear(i);
        });
        tb.add(yearChoice);

        tb.addSeparator();

        JLabel m = new JLabel("Miesiąc: ");
        tb.add(m);
        JButton prevMonth = new JButton("<");
        prevMonth.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                changeMonth(month - 1);
            }
        });
        tb.add(prevMonth);
        JButton nextMonth = new JButton(">");
        nextMonth.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                changeMonth(month+1);
            }
        });
        tb.add(nextMonth);

        monthChoice = new JScrollBar(JScrollBar.HORIZONTAL, month, 1, 0, 12);
        monthChoice.addAdjustmentListener(e -> {
            int i = monthChoice.getValue();
            changeMonth(i);
        });
        tb.add(monthChoice);

        add(tb, BorderLayout.SOUTH);
    }
    private void changeMonth(int newMonth){
        if(newMonth == 12) {
            newMonth = 0;
            changYear(year + 1);
        }
        if(newMonth == -1){
            newMonth = 11;
            changYear(year - 1);
        }
        month = newMonth;
        monthChoice.setValue(month);
        tp.setTitleAt(1, DataModel.monthToString[month]);
        int y[] = {(month == 0) ? year - 1 : year, year, (month == 11) ? year + 1 : year};
        int m[] = {(month == 0) ? 11 : month - 1, month, (month == 11) ? 0 : month + 1};
        for(int i = 0; i < 3; i++){
            MonthPanelList mpl = monthsList.get(i);
            mpl.change(y[i], m[i]);
        }
    }
    private void changYear(int newYear){
        year = newYear;
        yearChoice.setValue(year);
        tp.setTitleAt(0, String.valueOf(year));
        for(int i = 0; i < 12; i++){
            MonthPanel mp = months.get(i);
            mp.change(year);
        }
        changeMonth(month);
    }


    private class MonthPanelList extends JPanel{
        private DataModel model;
        private JList list;
        private int year, month;

        public MonthPanelList(int year, int month){
            this.year = year;
            this.month = month;
            model = new DataModel(year, month);
            list =  new JList(model);
            list.setCellRenderer(new MonthCellRenderer());
            list.setBackground(null);
            add(list);
            setTitle();
        }

        public void setTitle(){
            setBorder(BorderFactory.createTitledBorder(DataModel.monthToString[month] + " " + year));
        }

        public void change(int year, int month){
            this.year = year;
            this.month = month;
            model.change(year, month);
            setTitle();
        }
    }

    private class MonthPanel extends JPanel{
        private DataModel model;
        private int month, year;

        public MonthPanel(int year, int month){
            this.month = month;
            this.year = year;
            model = new DataModel(year, month);
            paintGrid();
            setTitle();
        }

        public void paintGrid(){
            int numberOfDays = model.getSize();
            int firstDay = model.getWeekdayNumber(0);

            int rows = 0;
            if(firstDay == 0){ //pierwszy dzień to poniedziałek
                rows = numberOfDays/7;
                if(numberOfDays % 7 != 0) rows++;
            }
            else{
                int tmp = numberOfDays - (7 - firstDay);
                rows = tmp/7;
                if(tmp % 7 != 0) rows++;
                rows++;
            }
            setLayout(new GridLayout(rows + 1, 7));

            for(int i = 0; i < 7; i++){
                JLabel tmp =  new JLabel(DataModel.dayToStringShort[i], SwingConstants.CENTER);
                if((i +1)%7 == 0) tmp.setForeground(Color.RED);
                add(tmp);
            }

            for(int i = 0; i < rows*7; i++){
                int k = 0;
                if(year == 1582 && month == 9 && i >= 4) k = 10;
                if(i < firstDay || i - firstDay >= numberOfDays) add(new JLabel(" ", SwingConstants.CENTER));
                else{
                    JLabel tmp =  new JLabel(String.valueOf(i + k - firstDay + 1), SwingConstants.CENTER);
                    if((i + 1)%7 == 0) tmp.setForeground(Color.RED);
                    add(tmp);
                }

            }
        }
        public void setTitle(){
            setBorder(BorderFactory.createTitledBorder(DataModel.monthToString[month]));
        }

        public void change(int year){
            this.year = year;
            model.setYear(year);
            removeAll();
            paintGrid();
            validate();
            setTitle();
        }
    }

    private class MonthCellRenderer extends JLabel implements ListCellRenderer{
        public MonthCellRenderer(){
            setHorizontalAlignment(LEFT);
        }

        @Override
        public Component getListCellRendererComponent(JList jList, Object o, int i, boolean b, boolean b1) {
            String text = (String) o;
            String [] res = text.split(" ");
            setText(res[1] + " " + res[0]);
            setForeground(Color.BLACK);
            if(res[0].equals("Niedziela")) {
                setForeground(Color.RED);
            }
            return this;
        }
    }
}
