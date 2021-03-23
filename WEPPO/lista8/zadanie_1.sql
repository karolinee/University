drop table if exists "osoba_v1" cascade;
drop table if exists "osoba_v2" cascade;


CREATE TABLE osoba_v1 (
    id_osoba integer NOT NULL,
    imie character varying(15) NOT NULL, 
    nazwisko character varying(30) NOT NULL,
    plec character(1) NOT NULL
);
-- imie i nazwisko to kolumny znakowe o zmiennej długości z limitem kolejno 15 i 30 znaków
-- polskie imiona i nazwiska powinny się mieścić w tym limicie
-- płeć to tylko 1 znak - m lub k 


-- sekwencja dostarczającą wartośc klucza głównego 
CREATE SEQUENCE id_osoby INCREMENT 1 START 1 OWNED BY osoba_v1.id_osoba;

INSERT INTO osoba_v1(id_osoba,imie, nazwisko, plec) VALUES (nextval('id_osoby'),'Anna', 'Kowalska', 'k');
INSERT INTO osoba_v1(id_osoba,imie, nazwisko, plec) VALUES (nextval('id_osoby'),'Anna', 'Mazik', 'k');
INSERT INTO osoba_v1(id_osoba,imie, nazwisko, plec) VALUES (nextval('id_osoby'),'Adam', 'Nowak', 'm');
INSERT INTO osoba_v1(id_osoba,imie, nazwisko, plec) VALUES (nextval('id_osoby'),'Jan', 'Kowalski', 'm');

SELECT * FROM osoba_v1;
SELECT imie FROM osoba_v1 WHERE plec='m';


-- tabela z serial primary key
CREATE TABLE osoba_v2 (
    id_osoba SERIAL PRIMARY KEY, 
    imie character varying(15) NOT NULL,
    nazwisko character varying(30) NOT NULL,
    plec character(1) NOT NULL
);

INSERT INTO osoba_v2(imie, nazwisko, plec) VALUES ('Anna', 'Kowalska', 'k');
INSERT INTO osoba_v2(imie, nazwisko, plec) VALUES ('Anna', 'Mazik', 'k');
INSERT INTO osoba_v2(imie, nazwisko, plec) VALUES ('Adam', 'Nowak', 'm');
INSERT INTO osoba_v2(imie, nazwisko, plec) VALUES ('Jan', 'Kowalski', 'm');

SELECT * FROM osoba_v2;
SELECT imie FROM osoba_v2 WHERE plec='m';