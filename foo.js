var express = require('express');
var redis = require('redis');
var client = redis.createClient();
var app = express();




app.get('/', function (req, res) {
   client.incr("visitors", function(err, reply) {	
  	res.send("Hello visitor " + reply);
	});
});

app.listen(3000);

// var server = app.listen(process.env.PORT || 3000, function () {

//   var host = server.address().address;
//   var port = server.address().port;

//   console.log('Example app listening at http://%s:%s', host, port);

// });

