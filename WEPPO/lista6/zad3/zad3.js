var http = require('http');
var express = require('express');
var cookieParser = require('cookie-parser');
var session = require('express-session');
var FileStore = require('session-file-store')(session);

var app = express();

app.set('view engine', 'ejs');
app.set('views', './views');

app.disable('etag');

app.use(cookieParser());

 
var fileStoreOptions = {};
 
app.use(session({
    store: new FileStore(fileStoreOptions),
    secret: 'zad3',
    resave: true,
    saveUninitialized: true
}));
app.use(express.urlencoded({
    extended: true
}));

app.get("/", (req, res) => { 
    var cookieValue;
    if (!req.cookies.cookie) {
        cookieValue = new Date().toString();
        res.cookie('cookie', cookieValue);
    } else {
        cookieValue = req.cookies.cookie;
    }

    if(!req.session.views){
        req.session.views = 1;
    }
    else{
        req.session.views++;
    }
    res.render("index", { cookieValue: cookieValue, sessionViews: req.session.views});
});


app.get("/remCookie", (req, res) => {
    res.cookie('cookie', '', {maxAge: -1});  
    res.render('removed', {text: 'cookie'});
});

app.get("/remSessionViews", (req, res) => {
    delete req.session.views;
    res.render('removed', {text: 'view count from session'});
});


http.createServer(app).listen(8080);
console.log('starting')

//żeby sprawdzić czy przeglądarka obsługuje cisteczka można użyć navigator.cookieEnabled jednak nie jest to obsługiwane przez wszystkie przeglądarki
//drugim sposobem jest próba utworzenia ciasteczka, a później próba jego odczytu - jak odczytamy i dostaniemy oczekiwaną wartość to przeglądarka obsługuje ciasteczka