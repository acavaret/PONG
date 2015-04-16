var express = require('express');
//var redis = require('redis');
//var client = redis.createClient();
var app = express();

if (process.env.REDISTOGO_URL) {
    var rtg   = require("url").parse(process.env.REDISTOGO_URL);
	var client = require("redis").createClient(rtg.port, rtg.hostname);

	client.auth(rtg.auth.split(":")[1]);
	} else {
    var client = require("redis").createClient();
}


app.get('/most-recent', function (req, res) {
   client.lindex("visitors", 0, function(err, visitorCount)  {	
  	res.send("There are " + visitorCount + " visitors");
	});
});

app.get('/how-many', function (req, res) {
   client.llen("visitors", function(err, visitorCount)  {	
  	res.send("There are " + visitorCount + " visitors");
	});
});


app.get('/', function (req, res) {
   //client.incr("visitors", function(err, reply);
   client.lpush("visitors", req.ip, function(err, reply)  {	
  	res.send("Hello visitor number " + reply + " and your IP is " + req.ip);
	});
});

app.listen(process.env.PORT || 3000);

// var server = app.listen(process.env.PORT || 3000, function () {

//   var host = server.address().address;
//   var port = server.address().port;

//   console.log('Example app listening at http://%s:%s', host, port);

// });

