var express = require('express');
var app = express();


var redis = require("redis").createClient();


app.get('/', function (req, res) {
  client.get("Hello", function(err, reply){
  	res.send('Hello ' + reply);
  })
});

var server = app.listen(process.env.PORT || 3000, function () {

  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);

});

