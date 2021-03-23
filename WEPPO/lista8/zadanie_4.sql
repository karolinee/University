drop table if exists "miejsce_pracy" cascade;
drop table if exists "osoba" cascade;

CREATE TABLE miejsce_pracy(
    id_miejsce_pracy SERIAL PRIMARY KEY,
    nazwa character varying(30) NOT NULL,
    miasto character varying(30) NOT NULL
);

CREATE TABLE osoba (
    id_osoba SERIAL PRIMARY KEY,
    imie character varying(15) NOT NULL,
    nazwisko character varying(30) NOT NULL,
    id_miejsce_pracy integer REFERENCES miejsce_pracy(id_miejsce_pracy)
);

