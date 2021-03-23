var http = require('http');
var express = require('express');
var url = require('url');

var app = express();

app.set('view engine', 'ejs');
app.set('views', './views');

app.use(express.urlencoded({extended: true}));

app.get('/', (req, res) => {
    var r1 = {
        name : 'choice1',
        options: [
            {id: 1, val : 'elem1.1'},
            {id: 2, val : 'elem1.2'},
            {id: 3, val : 'elem1.3'},
        ]
    }

    var r2 = {
        name :'choice2',
        options: [
            {id: 1, val : 'elem2.1'},
            {id: 2, val : 'elem2.2'},
            {id: 3, val : 'elem2.3'},
            {id: 4, val : 'elem2.4'},
        ]
    }
    res.render('index', {r1, r2});
})

http.createServer(app).listen(8080);
console.log('starting')