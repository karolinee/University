function fibRec(n) {
    if(n < 2) return n;
    return fibRec(n-1) + fibRec(n-2);
}

function fibIter(n) {
    let f0 = 0, f1 = 1;
    for(i = 0; i < n ; i++) {
        [f0, f1] = [f1, f0+f1];
    }
    return f0;
}

function mem(f) {
    let cache = {}

    return function(n) {
        if(cache[n]) {
            return cache[n]
        }
        else {
            let f_n = f(n)
            cache[n] = f_n
            return f_n
        }
    }
}

let fibMem = mem(function(n){
    if(n < 2) return n;
    return fibMem(n-1) + fibMem(n-2);
})

let max = 42;
for(let i = 10; i <= max; i++) {
    console.log('i = ' + i);

    console.time('rec');
    fibRec(i);
    console.timeEnd('rec');

    console.time('iter');
    fibIter(i);
    console.timeEnd('iter');

    console.time('memo');
    fibMem(i);
    console.timeEnd('memo');
}

//implementacja z użyciem memoizacji jest dużo szybsza z dwóch powodów:
//1. zapamiętujemy wszystkie obliczenia pośrednie (fibMem jest rekurencyjna)
//2. wyliczamy kolejne liczby fib, więc przy kolejnych iteracjach korzystamy z poprzednich wyliczeń
