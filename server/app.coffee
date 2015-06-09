#Require de Node JS
fs = require 'fs'
path = require "path"
util = require 'util'
url = require 'url'

#Require de NPM
express = require('express')
app = express()
cookieParser = require('cookie-parser')
session = require('express-session')
bodyParser = require('body-parser')
jsend = require 'jsend'
uqamValidator = require 'uqam-validator'

#Require de nos libs
fondation = require './fondation'
fondationUqam = require './fondation-uqam'

#Configurer les variables d'exécution
port = process.env.PORT || 2015
repertoirePublic = process.env.REPERTOIRE_PUBLIC || './public'

#Configurer express
app.use(express.static(path.resolve(__dirname, repertoirePublic)));
app.use(cookieParser());
app.use(bodyParser.urlencoded({
  extended: false
}));
app.use(bodyParser.json());
app.use(session({
  secret: 'On est open source.',
  resave: true,
  saveUninitialized: true
}))
#inclure jsend en tant qu'intergiciel
app.use(jsend.middleware);

#Permettre les cors - Cross origine resource sharing
app.use (req, res, next) ->
  #On veut juste accepter les host uqam
  urlObj = url.parse(req.headers.referer || req.headers.origin)

  if (not uqamValidator.isDomaineUqam urlObj.host) and (urlObj.host isnt 'localhost:2015')
    #pas un domaine uqam access denied
    res.send(403)
    return

  res.header 'Access-Control-Allow-Origin',
    util.format '%s//%s', urlObj.protocol, urlObj.host

  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');

  # intercept OPTIONS method
  if 'OPTIONS' == req.method
    res.send(200)
    return
  else
    next()
    return

##router de fondation-uqam
app.post '/api/diplomes/coordonnees',
  (req, res) ->
    fondationUqam.modifierFicheDiplome req.body,
      (err, data)->
        if !err
          res.jsend.success data
        else
          return res.jsend.fail err


app.get '/api/diplomes/coordonnees',
  (req, res) ->
    fondationUqam.getFicheDiplomes (err, data)->
      if !err
        res.jsend.success data
      else
        return res.jsend.fail err


app.delete '/api/diplomes/coordonnees/:id',
  (req, res) ->
    console.log 'app.get /api/diplomes/id'
    fondationUqam.supprimerFicheDiplome req.params.id,
      (err, data)->
        if !err
          res.jsend.success data
        else
          return res.jsend.fail err

server = app.listen port,
  ()->
    host = server.address().address
    port = server.address().port
    console.log 'On part le serveur! http://%s:%s.', host, port


module.exports = app;