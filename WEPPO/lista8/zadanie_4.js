var pg = require('pg');
(async function main() {
    var pool = new pg.Pool({
        host: 'localhost',
        database: 'testdb',
        user: 'karolina',
        port: 5432,
        password: 'karolina',

 });
 try {
    var result = await pool.query("INSERT INTO miejsce_pracy(nazwa, miasto) VALUES ('PKO', 'Warszawa') RETURNING id_miejsce_pracy;");
    let fk = result.rows[0].id_miejsce_pracy;
    var result2 = await pool.query(`INSERT INTO osoba(imie, nazwisko, id_miejsce_pracy) VALUES ('Anna', 'Nowak', '${fk}')`);
 }
 catch ( err ) {
    console.log( err );
 }
})();