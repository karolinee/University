//zadanie korzysta z bazy utworzonej w pierwszym zadaniu

var pg = require('pg');

(async function main() {
   var pool = new pg.Pool({
      host: 'localhost',
      database: 'testdb',
      user: 'karolina',
      port: 5432,
      password: 'karolina',

   });
   //wstawanie i pobranie id pod który rekord został wstawiony
   try {
      var result = await pool.query("INSERT INTO osoba_v2(imie, nazwisko, plec) VALUES ('Bartosz', 'Kraśny', 'm') RETURNING id_osoba;");
      console.log(result.rows);
   }
   catch ( err ) {
      console.log( err );
   }

   //odczytywanie
   try {
      var result = await pool.query("SELECT * FROM osoba_v2");
      console.log(result.rows);
   }
   catch ( err ) {
      console.log( err );
   }
})();