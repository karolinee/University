import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.filechooser.FileFilter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;

public class Navigator extends JFrame{
    private DataModel model;
    private JList list;

    private JScrollPane sp;
    private JLabel catalogName;
    private JToolBar tb;


    public Navigator(){
        super("Nawigator po systemie plików");
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setSize(800,800);
        setLayout(new BorderLayout());

        model = new DataModel("/home/karolina");
        list = new JList(model);
        list.setCellRenderer(new FileCellRenderer());
        list.setBackground(null);
        list.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                if(e.getClickCount() == 2){
                    model.changeRoot(list.locationToIndex(e.getPoint()));
                    catalogName.setText(model.getCurrent());
                }
            }
        });
        list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        list.addListSelectionListener(le -> {
            int idx = list.getSelectedIndex();
            if (idx != -1) {
                model.setSelected(idx);
            }
        });

        catalogName = new JLabel(model.getCurrent());
        add(catalogName, BorderLayout.PAGE_START);

        sp = new JScrollPane(list);
        sp.setSize(800,800);
        add(sp, BorderLayout.CENTER);

        tb = new JToolBar();

        makeToolBar();
        add(tb, BorderLayout.PAGE_END);


        setVisible(true);
    }

    private void makeToolBar() {
        JButton fileChooser = new JButton("Wybierz folder");
        fileChooser.addActionListener(actionEvent -> {
            JFileChooser fc = new JFileChooser();
            fc.setCurrentDirectory(new File(model.getCurrent()));
            fc.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
            fc.setAcceptAllFileFilterUsed(false);
            int returnVal = fc.showOpenDialog(null);
            if(returnVal == JFileChooser.APPROVE_OPTION){
                model.changeRoot(fc.getSelectedFile());
                catalogName.setText(model.getCurrent());
            }
        });
        tb.add(fileChooser);
        tb.addSeparator();

        JButton remove = new JButton("Usuń plik");
        remove.addActionListener(actionEvent -> {
            if(model.isSelected()){
                int choice = JOptionPane.showOptionDialog(Navigator.this,
                        "Czy na pewno chcesz usunąć ten plik?",
                        "",
                        JOptionPane.YES_NO_OPTION,
                        JOptionPane.QUESTION_MESSAGE,
                        null,
                        new String[]{"Tak", "Nie"},
                        "Nie");
                if(choice == 0 ){
                    model.removeSelected();
                    model.setSelected(list.getSelectedIndex());
                }
            }

        });
        tb.add(remove);

        JButton rename = new JButton("Zmień nazwę");
        rename.addActionListener(actionEvent -> {
            if(model.isSelected() && model.isSelectedFile()){
                String newName = JOptionPane.showInputDialog("Podaj nową nazwę pliku");
                if(newName != null && !newName.equals("")){
                    model.changeName(newName);
                    model.setSelected(list.getSelectedIndex());
                }
            }

        });
        tb.add(rename);

        JButton copy = new JButton("Kopiuj");
        copy.addActionListener(actionEvent -> {
            if(model.isSelected() && model.isSelectedFile()){
                model.setToCopy();
            }
        });
        tb.add(copy);

        JButton paste = new JButton("Wklej");
        paste.addActionListener(actionEvent -> {
            try {
                model.copy();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
        tb.add(paste);

        JButton change = new JButton("Zmień kodowanie");
        change.addActionListener(actionEvent -> {
            if(model.isSelected() && model.isSelectedFile()){
                String encoding = (String)JOptionPane.showInputDialog(Navigator.this,
                        "Wskaż kodowanie źródłowe",
                        "",
                        JOptionPane.QUESTION_MESSAGE,
                        null,
                        new String[]{"US-ASCII", "ISO-8859-1" ,"ISO-8859-2"}, "US-ASCII");
                if(encoding != null && !encoding.equals("")){
                    try {
                        model.changeEncoding(encoding);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        });
        tb.add(change);

        JButton refresh = new JButton("Odśwież");
        refresh.addActionListener(actionEvent -> model.refresh());
        tb.add(refresh);


    }


    private class FileCellRenderer extends JLabel implements ListCellRenderer{

        @Override
        public Component getListCellRendererComponent(JList jList, Object o, int i, boolean isSelected, boolean cellHasFocus) {
            File f = (File) o;
            if(model.hasParent() && f.getName().equals(model.getParent())){
                setText("..");
            }
            else{
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
                setText(f.getName() + " " + sdf.format(f.lastModified()));
                setToolTipText(String.valueOf(f.length()));
            }
            if(f.isDirectory()){
                setForeground(Color.BLACK);
            }
            else{
                setForeground(Color.BLUE);
            }

            if (isSelected) {
                if(!getText().equals("..") && model.isSelected()){
                    setBackground(Color.red);
                    setOpaque(true);
                }
            }
            else {
                setOpaque(false);
            }


            return this;
        }
    }
}
