const fs = require('fs');
const util = require('util');

//klasyczny intefejs
fs.readFile('b.txt', 'utf8', (err, data) => {
    if(err){
        console.log('błąd ' + err);
    }
    else {
        console.log(data);
    }
});

//ręcznie napisana funckja zwracająca promise
function fspromise(path, enc) {
    return new Promise( (res, rej) => {
        fs.readFile(path, enc, (err, data) => {
            if(err){
                rej(err);
            }
            else {
                res(data);
            }
        })
    })
}
let promise1 = fspromise('b.txt', 'utf8');

//util.promisify
let promise2 = util.promisify(fs.readFile)('b.txt', 'utf8');

//util.promisify
let promise3 = fs.promises.readFile('b.txt', 'utf8');


//obsługa po staremu
promise1.then((data) => {
    console.log('\"po staremu\" -- promise1: ' + data);
});
//obsługa po nowemu
(async function() {
    let data = await promise1;
    console.log('\"po nowemu\" -- promise1 : ' + data);
})();


