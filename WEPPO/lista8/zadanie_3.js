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
   
   try {
      var result = await pool.query("UPDATE osoba_v2 SET imie='Aleksandra' WHERE nazwisko='Mazik'");
   }
   catch ( err ) {
      console.log( err );
   }

   try {
      var result = await pool.query("DELETE FROM osoba_v2 WHERE nazwisko='Nowak'");
   }
   catch ( err ) {
      console.log( err );
   }
})();