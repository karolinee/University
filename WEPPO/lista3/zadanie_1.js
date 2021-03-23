let person = {
    first_name : 'Jan',
    last_name : 'Kowalski',
    age: 19,
    make_older : function() {
        person.age++;
    }, 
    get name() {
        return person.first_name;
    },
    set name(n) {
        if (typeof n == 'string'){
            person.first_name = n;
        }
        else {
            console.log('imie musi być literałem');
        }
    }
}

Object.defineProperty(person, 'language', {
    value: 'polski'
})
Object.defineProperty(person, 'isAdult', {
    value: function() {
        return person.age >= 18;
    }
})
Object.defineProperty(person, 'city', {
    value: 'Wroclaw',
    writable: true
})

Object.defineProperty(person, 'address', {
    get : function () {
        return person.city
    },
    set : function (n) {
        if (typeof n == 'string'){
            person.city = n;
        }
        else {
            console.log('adres musi być literałem');
        }
    }
})

//pola i metody można też dodać za pomoca wcześniej poznanej składni (operator . lub []) 
//właściwości muszą być dodane poprzez Object.defineProperty