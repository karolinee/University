-- Karolina Jeziorska, pga
-- Zadanie 1
SELECT badges.name AS odznaka, COUNT(posts.id) AS liczba
FROM badges JOIN posts ON(badges.userid = posts.owneruserid)
GROUP BY badges.name
ORDER BY liczba DESC;

-- Zadanie 2
SELECT DISTINCT array_to_string(regexp_matches(text, '[^\w](\w{3,})\s+\1[^\w]'),'') AS text_final FROM (SELECT CONCAT(' ',text, ' ') AS text FROM comments) AS foo ORDER BY text_final;

-- Zadanie 3
--a
ALTER TABLE users ADD CONSTRAINT unique_id UNIQUE (id);
ALTER TABLE posts ADD CONSTRAINT fk_owneruserid FOREIGN KEY (owneruserid) REFERENCES users(id) ON DELETE SET NULL; 

--b
/*
W aktualnej formie raczej nie ma sensu ustawania tego pola na not null. Aktualnie wartość null daje nam jakąś informację - że użytkownik, który stworzył post posta już nie istnieje. Jednak jeżeli zostawimy nulle to możemy pomijać niektóre posty przy selectie więc może się opłacać ustawienie tego pola na not null i użycie jednej z poniższych możliwości:
1. Utworzenie użytkownika "deleted_user" z id zerowym lub ujemnym, któremu będziemy przypisywać wszystkie posty od użytkowników usuniętych.
ZALETY: nie rozbudowujemy dużo bazy, dodajemy tylko jednego użytkownika
WADY: trzeba napisać triggery na usuwanie użytkownika, które przypisują jego posty do "deleted_user", przy pisananiu zapytań o posty/użytkowników należy pamiętać o dodatkowym użytkowniku (jego uwzględnienie może zaburzać wyniki)
2. Utworzenie dodatkowej kolumny w tabeli users przechowującej informację czy użytkownik jest usunięty (wartosć domyśna - nie jest). W ewentualnościu usuwania użytkownika zmieniamy tylko wartość w tej tabeli. Żeby pozbyć się istniejących już wartościu null, należy odtworzyć uzytkowników na podstawie owneruserdisplayname. 
ZALETY: usunięcie użytkownika sprowadza się do ustawienia wartości w kolumnie 'usunięty', mimo usunięcia, później możemy odtworzyc posty użytkownika (może to być użytkownikowi potrzebne)
WADY: powiększamy bazę, trzeba napisać dodatkowe triggery/zasady na usunięcie użytkownika, mimo usunięcia pamiętamy dane użytkowników

Osobiście zostawiłabym aktualne rozwiązanie (użycie null). Należy tylko o tym pamiętać pisząc zapytania, by nie pominąć niektórych danych.
*/

