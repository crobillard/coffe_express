
#
# Module dependencies.
#

express        = require 'express'
favicon        = require 'serve-favicon'
morgan         = require 'morgan'
bodyParser     = require 'body-parser'
methodOverride = require 'method-override'
cookieParser   = require 'cookie-parser'
session        = require 'express-session'
errorhandler   = require 'errorhandler'



routes   = require './routes'
user     = require './routes/user'
http     = require 'http'
path     = require 'path'

app = express();

#
# all environments
#

app.set 'port', process.env.PORT || 3000
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'ejs'
app.use favicon(__dirname + '/public/images/favicon.ico')
app.use morgan('dev')
app.use bodyParser()
app.use methodOverride()
app.use cookieParser('your secret here')
app.use session()
app.use express.static(path.join(__dirname, 'public'))

# development only
if  'development' == app.get 'env'
    console.log "mod dev ON"
    app.use errorhandler()


app.get '/',      routes.index
app.get '/users', user.list

http.createServer(app).listen app.get('port'),
        () -> console.log 'Express server listening on port ' + app.get('port')

