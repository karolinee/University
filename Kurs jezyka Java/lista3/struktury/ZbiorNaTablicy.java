package struktury;

public class ZbiorNaTablicy extends Zbior{
    protected Para[] zbior;
    protected int idx = 0;

    public ZbiorNaTablicy() {
        zbior = new Para[10];
    }

    public ZbiorNaTablicy(int n) throws Exception {
        if(n < 2) throw new Exception("zbyt mały rozmiar zbioru");
        zbior = new Para[n];
    }


    @Override
    public Para szukaj(String k) throws Exception {
        for(int i = 0; i < idx; i++){
            if(zbior[i].klucz.equals(k)) return zbior[i];
        }
        throw new Exception("brak pary o zadanym kluczu");
    }

    @Override
    public void wstaw(Para p) throws Exception {
        if(idx == zbior.length) throw new Exception("zbior jest pełny");
       
        for(int i = 0; i < idx; i++){
            if(zbior[i].equals(p)) throw new Exception("para o takim  kluczu już istnieje");
        }
        
        zbior[idx++] = p;
    }

    @Override
    public void usun(String k) throws Exception {
        for(int i = 0; i < idx; i++){
            if(zbior[i].klucz.equals(k)){
                if(idx > 1) {
                    zbior[i] = zbior[idx - 1];
                }
                else {
                    zbior[i] = null;
                }
                idx--;
                return;
            } 
        }
        throw new Exception("para o takim  kluczu nie istnieje");
    }

    @Override
    public double czytaj(String k) throws Exception {
        for(int i = 0; i < idx; i++){
            if(zbior[i].klucz.equals(k)){
                return zbior[i].getWartosc();
            } 
        }
        throw new Exception("para o takim  kluczu nie istnieje");
    }

    @Override
    public void ustaw(Para p) throws Exception {
        for(int i = 0; i < idx; i++){
            if(zbior[i].equals(p)){
                zbior[i].setWartosc(p.getWartosc());
                return;
            } 
        }
        wstaw(p);
    }

    @Override
    public void czysc() {
        for(int i = 0; i < idx; i++){
            zbior[i] = null;
        }
        idx = 0;

    }

    @Override
    public int ile() {
        return idx;
    }
    
}
