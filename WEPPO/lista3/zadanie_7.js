function fib1(){
    let f0 = 0, f1 = 1;
    return {
        next: function() {
            [f0, f1] = [f1, f0+f1];
            return {
                value: f0,
                done: false
            }
        }
    }
}

function *fib2(){
    let f0 = 0, f1 = 1;
    while(true){
        [f0, f1] = [f1, f0+f1];
        yield f0;
    }
}

var _it = fib1();
for (var _result; _result = _it.next(), !_result.done;) {
    console.log(_result.value);
}

for (var i of fib2()) {
    console.log(i);
}
