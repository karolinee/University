function sum(...args) {
    let result = 0
    for(let elem of args) {
        result += elem;
    }
    return result
}

console.log(sum(1,2,3))
console.log(sum(1,2,3,4,5))