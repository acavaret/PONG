var express = require('express');
var app = express();

var express = require('redis');
var client = redis.createClient();


app.get('/', function (req, res) {
  res.send('Hello ' + client.get("hello"));
});

var server = app.listen(process.env.PORT || 5000, function () {

  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);

});