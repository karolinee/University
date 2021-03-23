import javax.swing.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Comparator;


public class DataModel extends AbstractListModel {
    private File root; //obecny katalog
    private File[] files; //podkatalogi i pliki
    private int size;

    private File parent; //katalog wyżej
    private File selected; //aktualnie zaznaczony katalog
    private File toCopy; //skopiowany katalog (gotowy do wklejenia)

    public DataModel(String path){
        root = new File(path);
        parent = root.getParentFile();
        loadFiles();
    }

    @Override
    public int getSize() {
        return size;
    }

    @Override
    public Object getElementAt(int i) {
        if(parent!=null){
            if(i < 0 || i >= size + 1)
                throw new ArrayIndexOutOfBoundsException();
            if(i == 0)
                return parent;
            else return files[i - 1];
        }
        else{
            if(i < 0 || i >= size)
                throw new ArrayIndexOutOfBoundsException();
            else return files[i];
        }
    }

    public void setSelected(int idx){
        File f = (File) getElementAt(idx);
        if(!f.equals(parent)){
            selected = f;
        }
    }

    public String getCurrent(){
        return root.getAbsolutePath();
    }

    public void changeRoot(int idx){
        File f = (File) getElementAt(idx);
        if(f != null){
            changeRoot(f);
        }
    }
    public void changeRoot(File f){
        if(f.isDirectory()){
            root = f;
            parent = root.getParentFile();
            loadFiles();
            selected = null;
            fireContentsChanged(this, 0, getSize()-1);
        }
    }

    public boolean hasParent(){
        return parent != null;
    }

    public String getParent(){
        if(parent == null) throw new NullPointerException();
        return parent.getName();
    }

    public boolean isSelected(){
        return selected!= null;
    }
    public boolean isSelectedFile(){
        return selected!= null && selected.isFile();
    }
    public void removeSelected() {
        selected.delete();
        loadFiles();
        selected = null;
        fireContentsChanged(this, 0, getSize()-1);
    }

    private void loadFiles() {
        files = root.listFiles();
        if(files != null){
            Arrays.sort(files, new FilesComparator());
            size = files.length;
        }
        else{
            size = 0;
        }
        if(parent!=null) size++;
    }

    public void changeName(String newName) {
        File f = new File(root, newName);
        if(!f.exists()){
            selected.renameTo(f);
            loadFiles();
            fireContentsChanged(this, 0, getSize()-1);
        }
    }

    public void setToCopy() {
        toCopy = selected;
    }

    public void copy() throws IOException {
        if(toCopy != null){
            InputStream is = null;
            OutputStream os = null;
            String newName = toCopy.getName();
            String extension = "";
            File destFile = new File(root, newName);
            while(destFile.exists()){ //dołożenie do nazwy _copy by się nie powtarzało
                int dotIdx= newName.lastIndexOf('.');
                if(dotIdx > 0){
                    extension = newName.substring(dotIdx);
                    newName = newName.substring(0, dotIdx);
                }
                newName = newName + "_copy";
                destFile = new File(root, newName + extension);
            }

            try {
                is = new FileInputStream(toCopy);
                os = new FileOutputStream(destFile);
                byte[] buffer = new byte[1024];
                int length;
                while ((length = is.read(buffer)) != -1) {
                    os.write(buffer, 0, length);
                }
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } finally {
                if(is != null) is.close();
                if(os != null) os.close();
                loadFiles();
                fireContentsChanged(this, 0, getSize() - 1);
            }
        }


    }

    public void changeEncoding(String enc) throws IOException {
        InputStream is = null;
        OutputStream os = null;
        Reader in = null;
        Writer out = null;
        String filename = "_newfile1234567890";
        File destFile = new File(root, selected.getName() + filename);
        try {
            is = new FileInputStream(selected);
            os = new FileOutputStream(destFile);
            in = new InputStreamReader(is,enc);
            out = new OutputStreamWriter(os, StandardCharsets.UTF_8);

            char[] buffer = new char[1024];
            int length;
            while ((length = in.read(buffer, 0, buffer.length)) != -1) {
                out.write(buffer, 0, length);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            if(in != null) in.close();
            if(out != null) out.close();
            if(is != null) is.close();
            if(os != null) os.close();
        }

        destFile.renameTo(selected);
    }

    public void refresh() {
        loadFiles();
        fireContentsChanged(this, 0, getSize() - 1);
    }

    public class FilesComparator implements Comparator<File> {

        @Override
        public int compare(File f1, File f2) {
            if(f1.isDirectory() && !f2.isDirectory()) return -1;
            if(!f1.isDirectory() && f2.isDirectory()) return 1;

            String n1 = f1.getName().toLowerCase();
            if(n1.indexOf(".") == 0) n1 = n1.substring(1);
            String n2 = f2.getName().toLowerCase();
            if(n2.indexOf(".") == 0) n2 = n2.substring(1);

            return n1.compareTo(n2);

        }
    }
}
