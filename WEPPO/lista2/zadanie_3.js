console.log( (![]+[])[+[]] + (![]+[])[+!+[]] + ([![]]+[][[]])[+!+[]+[+[]]] + (![]+[])[!+[]+!+[]] );
// wynik - napis fail, kolejne litery to wartości typu string połączone +

console.log((![]+[])[+[]])
// [] -> []
// ![] -> false (! konwertuje [] na bool, [] jest niepustym obiektem, więc ma wartość true, więc !true -> false)
// ![]+[] -> 'false' (+ wykonuje na obu agrumentach toString, więc 'false'+'' -> 'false')

// +[] -> 0 (unarny + wykonuje konwersje na liczbę)
// (![]+[])[+[]] -> 'false'[0] -> 'f'

console.log((![]+[])[+!+[]])
// ![]+[] -> 'false'

// !+[] -> true (! konwertuje +[] na bool, +[] -> 0 -> false, więc !false -> true)
// +!+[] -> 1 (unarny + wykonuje konwersje na liczbę)
// (![]+[])[+!+[]] -> 'false'[1] -> 'a'

console.log(([![]]+[][[]])[+!+[]+[+[]]])
//[![]] -> [false]
//[][[]] -> [][''] -> undefined ([] zostało skonwertowane do '', dostajemy undefined bo nie ma pola o takiej nazwie)
//[![]]+[][[]] -> [false] + unefined -> 'falseundefined' (jak wcześniej)

//[+[]] -> [0] (jak wcześniej)
//+!+[] -> 1 (jak wcześniej)
//+!+[]+[+[]] -> 1 + [0] -> '10' (jak wcześniej)
//([![]]+[][[]])[+!+[]+[+[]]] -> 'falseundefined'['10'] -> 'falseundefined'[10] = 'i'

console.log((![]+[])[!+[]+!+[]])
//(![]+[]) -> 'false'

//!+[] -> true
//!+[]+!+[] -> 2 (+ wykonuje konwertuje na liczby swoje argumenty (gdy to typy podstawowe), mamy true+true, więc 1+1 -> 2)
//(![]+[])[!+[]+!+[]] -> 'false'[2] = 'l'

