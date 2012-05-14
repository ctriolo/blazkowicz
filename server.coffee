assets  = require 'connect-assets'
express = require 'express'

app = express.createServer()

app.configure ->
  app.set 'view options', {layout: false}
  app.use assets()
  app.use express.static 'assets'

app.get '/', (req, res) ->
  res.render 'index.jade', {title: 'Hello'}

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
