var http = require('http');
var express = require('express');
var url = require('url');

var app = express();

app.set('view engine', 'ejs');
app.set('views', './views');

app.use(express.urlencoded({extended: true}));

app.get('/', (req, res) => {
    res.render('index', {fname:'', lname: '', tasks: []});
})

app.post('/', (req, res) => {
    var fname = req.body.fname;
    var lname = req.body.lname;
    var tasks = []
    for(var i = 0; i <  10; i++){
        tasks[i] = req.body[i.toString()];
    }
    console.log(tasks);
    if(fname && lname) {
        res.redirect(url.format({
            pathname:"/print",
            query: {
                fname: fname,
                lname: lname,
                tasks: tasks
            }
        }));
    }
    else {
        res.render('index', {fname: fname, lname: lname, tasks: tasks, error: 'Trzeba podać imię i nazwisko'});
    }
})

app.get('/print', (req, res) => {
    res.render('print', req.query);
})

http.createServer(app).listen(8080);
console.log('starting')
