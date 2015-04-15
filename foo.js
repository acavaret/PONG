var express = require('express');
var app = express();


var redis = require("redis").createClient();


app.get('/', function (req, res) {
  client.incr("visitors") // increment visitors
  client.get("visitors", function(err, value) {
    res.send('Hello visitor number ' + value + '!');
  });
});

var server = app.listen(process.env.PORT || 6379, function () {

  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);

});

