express = require('express')
path = require('path')
engines = require('consolidate')
passport = require('./passport')

calculator = require("./routes/calculator")
orders = require("./routes/orders")
sessions = require("./routes/sessions")(passport)
transactions = require("./routes/transactions")
users = require("./routes/users")(sessions)

app = express()
app.enable('trust proxy')
app.engine('html', require('mustache-express')())
app.set('view engine', 'html')
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + '/public'))
app.use(require('connect-assets')(src: 'public'))
app.use(express.bodyParser())
app.use(express.cookieParser())
app.use(express.session(secret: 'weareallmadeofstars', cookie: { secure: true }, key: 'pos.sid'))
app.use(passport.initialize())
app.use(passport.session())
app.use(app.router)

authorize = (req, res, next) ->
  if req.params.user is req.user?.username or 
    req.user?.username is 'admin'
      return next() 
  res.redirect('/login')

app.get('/', sessions.new)
app.get('/register', users.new)
app.get('/ticker', calculator.ticker)

app.get('/login', sessions.new)
app.post('/login', sessions.create)
app.get('/logout', sessions.destroy)

app.get('/:user/exists', users.exists)
app.get('/:user.json', users.json)

app.get('/users', users.index)
app.get('/users/new', users.new)
app.post('/users', users.create)

app.get('/:user/edit', authorize, users.edit)
app.post('/:user/update', authorize, users.update)

app.get('/:user/transactions.json', authorize, transactions.json)
app.post('/:user/transactions', transactions.create)
app.get('/:user/report', authorize, transactions.index)
app.get('/:user/dashboard', users.dashboard)
app.get('/:user', users.show)

app.get('/:user/orders.json', authorize, orders.json)
app.post('/:user/orders', authorize, orders.create)

app.use((err, req, res, next) ->
  return next() unless err 
  res.status(500)
  console.log(err)
  res.end()
)

app.listen(3000)
