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


let max = 42;
for(let i = 10; i <= max; i++) {
    console.log('i = ' + i);

    console.time('rec');
    fibRec(i);
    console.timeEnd('rec');

    console.time('iter');
    fibIter(i);
    console.timeEnd('iter');
}

//czasy w środowisku node.js i Chrome podobne, a w Firefoxie zdecydownanie większe

