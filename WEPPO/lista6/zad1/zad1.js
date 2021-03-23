var http = require('http');
var express = require('express');
var multer  = require('multer');
var storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'uploads')
    },
    filename: function (req, file, cb) {
      cb(null, file.fieldname)
    }
  })
   
var upload = multer({ storage: storage })

var app = express();

app.use(express.urlencoded({extended: true}));

app.get('/',function(req,res){
    res.sendFile(__dirname + '/index.html');   
});

app.post('/uploadfile', upload.single('myFile'), (req, res) => {
    var file = req.file
    if (!file) {
        res.send("Nie wysłałeś żadnego pliku!");
    }
    else{
        res.send("Wysłałeś plik!"); 
    }
})

http.createServer(app).listen(8080);
console.log('starting')