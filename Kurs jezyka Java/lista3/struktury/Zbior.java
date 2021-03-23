package struktury;

public abstract class Zbior{

    //szuka w zbiorze pary o zadanym kluczu wpp rzuca wyjątek
    public abstract Para szukaj(String k) throws Exception;

    //wstawienie nowej pary do zbioru, wyjątek jak już istnieje
    public abstract void wstaw(Para p) throws Exception;

    //usunięcie pary o kluczu, wyjątek jak nie ma
    public abstract void usun(String k) throws Exception;

    //zwrócenie wartości z pary, wyjątek jak nie ma
    public abstract double czytaj(String k) throws Exception;

    //wstawienie lub zaktualizowanie pary
    public abstract void ustaw(Para p) throws Exception;

    //usuniecie wzystkich par
    public abstract void czysc();

    //ile par w zbiorze
    public abstract int ile();
}