console.log('----------Podpunkt 1----------')
let a = {}

a.foo = 1
a['bar'] = 2
a['foo bar'] = 3
let key = 'foo'
a[key] = 4
a[key + ' bar'] = 5

console.log(a);;
/* 
[] daje więcej możliwość:
- argumentem może też być wyrażenie lub zmienna
- możemy odwoływać sie do kluczy, które zawierają spacje 
*/

console.log('----------Podpunkt 2----------')
let b = {}
let c = {
    toString: function() {
        return "obiekt c"
    }
}
 
b[1] = 1
//liczba ma być kluczem pola, więc zostaje zmieniona na literał

b[a] = 2
b[c] = 3
//obiekt ma byc kluczem pola, więc zostaje zmieniony na literał (wywołana metoda toString)

console.log(b);;
/*
w przypadku liczby kontrola programisty jest oczywista - jaką liczbę podamy, taki odpowiadający string będzie kluczem
w przypadku obiektu mamy 2 mozliwości:
- metoda toString nie została zdefiniowana w obiekcie - brak kontroli, dostajemy literał '[object Object]'
- metoda toString została zdefiniowana w obiekcie - dostajemy jako klucz wynik wywołania metody toString
*/


console.log('----------Podpunkt 3----------')
let arr = []

arr['0'] = 1
arr['1'] = 2
arr['foo'] = 3
console.log(arr)
console.log(arr.length)
//jeżeli literałem jest wartość, którą możemy skonwertować na liczbę, zostanie to zrobione, wpp do obiektu jakim jest lista zostanie dodane pole o podanym kluczu
 
arr[a] = 4
arr[c] = 5
console.log(arr)
console.log(arr.length)
//analogicznie jak wcześniej

//jeżeli dodamy pole o kluczu niebędącym liczbą, sama lista się nie zmieni, ale w obiekcie jakim jest lista zostanie dodane to pole

arr.length = 5
console.log(arr)

arr.length = 1
console.log(arr)

//zmienienie długości listy zwiększa (dodaje puste pola) ją lub zmniejsza (oczywiście nie wpływa to na pola z nazwanymi kluczami)