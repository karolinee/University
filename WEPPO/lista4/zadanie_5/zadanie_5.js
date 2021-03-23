const fs = require('fs')

fs.readFile('a.txt', 'utf8', (err, data) => {
    if(err){
        console.log('błąd ' + err);
    }
    else {
        console.log(data);
    }
});