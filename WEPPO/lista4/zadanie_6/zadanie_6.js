const readline = require('readline');
const fs = require('fs');
const rl = readline.createInterface({
    input: fs.createReadStream('log.txt')
});

let ip = {};

rl.on('line', (line) => {
    let tmp = line.split(" ")[1];
    let old_val = ip[tmp] || 0;
    ip[tmp] = ++old_val;
})


rl.on('close', () => {
    let sorted_ip = Object.keys(ip).map(function(key) {
        return [key, ip[key]];
    });
    sorted_ip.sort(function(first, second) {
        return second[1] - first[1];
    });

    for(let i = 0; i < 3; i++){
        console.log(sorted_ip[i][0] + " " + sorted_ip[i][1]);
    }

})

