app.set('port', (process.env.PORT || 5000));

var app = express();

app.set('port', (process.env.PORT || 5000));
app.use(express.static(__dirname + '/public'));

var studentCount = 15;
var className ="Large Systems"

function greetClass(n, c) {
console.log("Hello," + n + ", there are " + c + " of you!")
}

greetClass(className, studentCount);