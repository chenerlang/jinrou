# HTTP Middleware Config
# ----------------------

# Version 2.0

# This file defines how incoming HTTP requests are handled

# CUSTOM MIDDLEWARE

# Hook-in your own custom HTTP middleware to modify or respond to requests before they're passed to the SocketStream HTTP stack

custom = ->

  (request, response, next) ->
    if request.url=="/"
      console.log 'This is my custom middleware. The URL requested is', request.url
      console.log request.connection.address().address
    # Unless you're serving a response you'll need to call next() here 
    next()
    
referrerstop=(request, response, next)->
  unless /^http:\/\/masao\.kuronowish\.com/.test request.headers.referer
    next()
    return  
  response.statusCode=403
  response.end """
<!doctype html>
<html><head><meta charset="UTF-8"><title>403 Forbidden</title></head>
<body><h1>403 Forbidden</h1><p>Bad referrer</p><footer><p><small>&copy; 2011-2012 うひょ</small></p></footer></body></html>"""
  
   

# CONNECT MIDDLEWARE

# connect = require('connect')

# Stack for Primary Server
exports.primary =
  [
    #connect.logger()            # example of calling in-built connect middleware. be sure to install connect in THIS project and uncomment out the line above
    #require('connect-i18n')()   # example of using 3rd-party middleware from https://github.com/senchalabs/connect/wiki
    #custom()                      # example of using your own custom middleware (using the example above)
    referrerstop
  ]

# Stack for Secondary Server
exports.secondary = []
