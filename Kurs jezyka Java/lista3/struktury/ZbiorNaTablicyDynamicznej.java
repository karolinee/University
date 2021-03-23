package struktury;

public class ZbiorNaTablicyDynamicznej extends ZbiorNaTablicy{

    public ZbiorNaTablicyDynamicznej() throws Exception {
        super(2);
    }


    @Override
    public void wstaw(Para p) throws Exception {
        for(int i = 0; i < idx; i++){
            if(zbior[i].equals(p)) throw new Exception("para o takim  kluczu już istnieje");
        }
        
        if(idx == zbior.length) {
            Para[] tmp = new Para[2 * idx];

            System.arraycopy(zbior, 0, tmp, 0, idx);
            zbior = tmp;
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

                if(idx < zbior.length/4){
                    Para[] tmp = new Para[zbior.length/2];
                    System.arraycopy(zbior, 0, tmp, 0, idx);
                    zbior = tmp;
                }
                return;
            } 
        }
        throw new Exception("para o takim  kluczu nie istnieje");
    }

    @Override
    public void czysc() {
        super.czysc();
        zbior = new Para[2];
    }

    //pomocnicza funckja do testow dynamicznej tablicy
    public int getLength(){
        return zbior.length;
    }

    
}
