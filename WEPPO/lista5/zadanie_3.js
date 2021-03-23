var http = require('http');
var server =
    http.createServer(
    (req, res) => {
        res.setHeader('Content-disposition', 'attachment; filename="hello_file.txt"');
        res.end('Hello world!');
 });
server.listen(8080);
console.log('started');