function *take(it, top) {
    while(top--){
        yield it.next().value;
    }
}

function *fib(){
    let f0 = 0, f1 = 1;
    while(true){
        [f0, f1] = [f1, f0+f1];
        yield f0;
    }
}

for(let num of take(fib(), 10)) {
    console.log(num)
}
