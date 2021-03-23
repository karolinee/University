function forEach( a, f ) {
    for(let elem of a) {
        f(elem);
    }
}

function map( a, f ) {
    for(let i = 0; i < a.length; i++) {
        a[i] = f(a[i]);
    }
}
function filter( a, f ) {
    let i = 0
    while(i < a.length) {
        if(f(a[i])) {
            i++
        }
        else {
            a.splice(i, 1)
        }
    }
}



let a = [1,2,3,4];

forEach(a, function(x) { console.log(x); } )
forEach(a, _ => { console.log( _ ); } )

let a2 = [...a]

map( a, _ => _ * 2 );
map( a2, function(x) { return x*2; })
console.log(a)
console.log(a2)

filter( a, _ => _ < 6);
filter( a2, function(x) { return x < 6; })
console.log(a)
console.log(a2)