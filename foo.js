var express = require('express');
var app = express();

var express = require('redis');
var client = redis.createClient();


app.get('/', function (req, res) {
  client.incr("visitors") // increment visitors
  client.get("visitors", function(err, value) {
    res.send('Hello visitor number ' + value + '!');
});

var server = app.listen(process.env.PORT || 3000, function () {

  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);

});