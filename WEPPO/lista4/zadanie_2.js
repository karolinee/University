//Qux jako funkcja zagnieżdżona w Bar
function Foo() {
}
Foo.prototype.Bar = function() {
    function Qux() {
        console.log("Qux");
    }
    Qux();
}


let foo = new Foo();
foo.Bar();


//Qux jako symbol prywatny 
var Foo1 = (function() {
    let symQux = Symbol('Qux');
        
    function Foo1(){
        this[symQux] = () => console.log('Qux');
    }
    

    Foo1.prototype.Bar = function() {
        this[symQux]();
    }

    return Foo1;
}());

let foo1 = new Foo1();

foo1.Bar();

