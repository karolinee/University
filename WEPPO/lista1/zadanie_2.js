
function divideCheck(number) {
    let number_copy = number;
    let sum = 0;
    while(number_copy > 0) {
        let temp = number_copy % 10;
        if(number % temp != 0) return false;
        
        sum += temp;
        number_copy = Math.floor(number_copy/10);
    }
    return (number % sum == 0);
}


let numbers = []
for(let i = 1 ; i <= 100000 ; i++) {
    if(divideCheck(i)) numbers.push(i);
}

console.log(numbers)