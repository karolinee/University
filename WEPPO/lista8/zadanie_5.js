var pg = require('pg');

var pool = new pg.Pool({
    host: 'localhost',
    database: 'testdb',
    user: 'karolina',
    port: 5432,
    password: 'karolina',

});

async function add(job, city, name, surname) {
        
 try {
    var result = await pool.query(`INSERT INTO miejsce_pracy(nazwa, miasto) VALUES ('${job}', '${city}') RETURNING id_miejsce_pracy;`);
    let id_job = result.rows[0].id_miejsce_pracy;
    var result2 = await pool.query(`INSERT INTO osoba(imie, nazwisko) VALUES ('${name}', '${surname}') RETURNING id_osoba;`);
    let id_person = result2.rows[0].id_osoba;
    var result3 = await pool.query(`INSERT INTO osoba_praca(id_osoba, id_miejsce_pracy) VALUES ('${id_job}', '${id_person}')`);
 }
 catch ( err ) {
    console.log( err );
 }
};

(async function main(){
    add('Pko', 'Warszawa', 'Anna', 'Nowak');
    add('Uwr', 'Wrocław', 'Jan', 'Kowal');
}
)();