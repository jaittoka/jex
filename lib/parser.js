(function() {
  var T_END, T_ID, T_LBRACKET, T_LPAREN, T_NUMBER, T_RBRACKET, T_RPAREN, T_STRING, identifier, isDigit, isId, isIdStart, lexer, parse, parseExpList, parseExpression;

  identifier = require('./runtime').identifier;

  T_END = 0;

  T_NUMBER = 1;

  T_ID = 2;

  T_STRING = 3;

  T_LPAREN = 4;

  T_RPAREN = 5;

  T_LBRACKET = 6;

  T_RBRACKET = 7;

  isId = function(c) {
    return (c >= 97 && c <= 122) || (c >= 65 && c <= 90) || (c >= 48 && c <= 57) || c === 36;
  };

  isIdStart = function(c) {
    return (c >= 97 && c <= 122) || (c >= 65 && c <= 90) || c === 95 || c === 36;
  };

  isDigit = function(c) {
    return c >= 48 && c <= 57;
  };

  lexer = function(str, pos) {
    var len, res;
    if (pos == null) {
      pos = 0;
    }
    len = str.length;
    res = {
      token: T_END,
      lexeme: null
    };
    return function() {
      var c, ch, lf;
      if (pos >= len) {
        res.token = T_END;
        res.lexeme = null;
        return res;
      }
      while ((c = str.charAt(pos)) === ' ' || (c === '\t') || (c === '\r') || (c === '\n')) {
        pos++;
      }
      ch = str.charCodeAt(pos);
      if (ch === 40) {
        pos++;
        res.token = T_LPAREN;
        res.lexeme = null;
      } else if (ch === 41) {
        pos++;
        res.token = T_RPAREN;
        res.lexeme = null;
      } else if (ch === 91) {
        pos++;
        res.token = T_LBRACKET;
        res.lexeme = null;
      } else if (ch === 93) {
        pos++;
        res.token = T_RBRACKET;
        res.lexeme = null;
      } else if (isDigit(ch)) {
        res.lexeme = '';
        while (isDigit(ch) || (ch === 46)) {
          res.lexeme += String.fromCharCode(ch);
          ch = str.charCodeAt(++pos);
        }
        res.token = T_NUMBER;
      } else if ((ch === 34) || (ch === 39)) {
        lf = ch;
        res.lexeme = '';
        while ((++pos < len) && (ch = str.charCodeAt(pos)) !== lf) {
          if (ch === '\\') {
            ch = str.charCodeAt(++pos);
          }
          res.lexeme += String.fromCharCode(ch);
        }
        if (ch === lf) {
          pos++;
        }
        res.token = T_STRING;
      } else {
        res.lexeme = '';
        while ((pos < len) && (ch !== 40) && (ch !== 41) && (ch !== 34) && (ch !== 32) && (ch !== 9) && (ch !== 10) && (ch !== 13)) {
          res.lexeme += String.fromCharCode(ch);
          ch = str.charCodeAt(++pos);
        }
        res.token = T_ID;
      }
      return res;
    };
  };

  parseExpList = function(l) {
    var e, result;
    result = [];
    while ((e = parseExpression(l)) != null) {
      result.push(e);
    }
    return result;
  };

  parseExpression = function(l) {
    var r, res;
    r = l();
    switch (r.token) {
      case T_LPAREN:
        return parseExpList(l);
      case T_LBRACKET:
        res = parseExpList(l);
        res.unshift(identifier('array'));
        return res;
      case T_ID:
        if (r.lexeme === 'false') {
          return false;
        } else if (r.lexeme === 'true') {
          return true;
        } else {
          return res = identifier(r.lexeme);
        }
        break;
      case T_STRING:
        return r.lexeme;
      case T_NUMBER:
        return parseFloat(r.lexeme);
      default:
        return null;
    }
  };

  parse = function(str) {
    return parseExpression(lexer(str));
  };

  module.exports = parse;

}).call(this);
