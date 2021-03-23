function createFs(n) {
    var fs = []
    for(var i = 0; i < n; i++) {
        fs[i] = function() {
                return i;
            };
    };
    return fs;
}

var myfs = createFs(10);

console.log(myfs[0]())
console.log(myfs[2]())
console.log(myfs[7]())

//dzieje się tak ponieważ tworzone funkcje dzielą środowisko - i w każdej funcji odnosi się do tej samej zmiennej z zewnątrz funkcji
//zmiana var na let w for sprawia, że każda iteracja pętli będzie miała nową (osobną) zmienną i

function createFs2(n) {
    var fs = []
    for(var i = 0; i < n; i++) {
        fs[i] = (function (idx) {
            return function () {
                return idx;
            }
        })(i)
    };
    return fs;
}

var myfs2 = createFs2(10);

console.log(myfs2[0]())
console.log(myfs2[2]())
console.log(myfs2[7]())