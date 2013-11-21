{ identifier }   = require './runtime'

T_END = 0
T_NUMBER = 1
T_ID = 2
T_STRING = 3
T_LPAREN = 4
T_RPAREN = 5
T_LBRACKET = 6
T_RBRACKET = 7

isId = (c) -> (c >= 97 and c <= 122) or (c >= 65 and c <= 90) or (c >= 48 and c <= 57) or c is 36

isIdStart = (c) -> (c >= 97 and c <= 122) or (c >= 65 and c <= 90) or c is 95 or c is 36

isDigit = (c) -> c >= 48 and c <= 57

lexer = (str, pos = 0) ->
  len = str.length
  res = 
    token: T_END
    lexeme: null
  () ->
    if pos >= len
      res.token = T_END
      res.lexeme = null
      return res

    while (c = str.charAt(pos)) is ' ' or (c is '\t') or (c is '\r') or (c is '\n')
      pos++

    ch = str.charCodeAt pos
    if ch is 40
      pos++
      res.token = T_LPAREN
      res.lexeme = null
    else if ch is 41
      pos++
      res.token = T_RPAREN
      res.lexeme = null
    else if ch is 91
      pos++
      res.token = T_LBRACKET
      res.lexeme = null
    else if ch is 93
      pos++
      res.token = T_RBRACKET
      res.lexeme = null
    else if isDigit ch
      res.lexeme = ''
      while isDigit(ch) or (ch is 46)
        res.lexeme += String.fromCharCode ch        
        ch = str.charCodeAt ++pos
      res.token = T_NUMBER        
    else if (ch is 34) or (ch is 39) # quoted string
      lf = ch
      res.lexeme = ''
      while (++pos < len) and (ch = str.charCodeAt pos) isnt lf
        ch = str.charCodeAt ++pos if ch is '\\'
        res.lexeme += String.fromCharCode ch
      pos++ if ch is lf
      res.token = T_STRING
    else 
      res.lexeme = ''
      while (pos < len) and (ch isnt 40) and (ch isnt 41) and (ch isnt 34) and (ch isnt 32) and (ch isnt 9) and (ch isnt 10) and (ch isnt 13)
        res.lexeme += String.fromCharCode ch
        ch = str.charCodeAt ++pos
      res.token = T_ID

    res

parseExpList = (l) -> 
  result = []
  while (e = parseExpression(l))?
    result.push e
  result

parseExpression = (l) ->
  r = l()
  switch r.token
    when T_LPAREN
      parseExpList l
    when T_LBRACKET
      res = parseExpList l
      res.unshift identifier 'array'
      res
    when T_ID
      if r.lexeme is 'false'
        false
      else if r.lexeme is 'true'
        true
      else
        res = identifier r.lexeme
    when T_STRING
      r.lexeme
    when T_NUMBER
      parseFloat r.lexeme
    else
      null

parse = (str) -> parseExpression lexer str

module.exports = parse
