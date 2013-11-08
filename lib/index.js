(function() {
  var Compiler, compile, compileToFunction, parse;

  parse = require('./parser');

  Compiler = require('./compiler');

  compile = function(str) {
    var c;
    c = new Compiler;
    return c.compile(parse(str));
  };

  compileToFunction = function(str) {
    var c;
    c = new Compiler;
    return c.compileToFunc(parse(str));
  };

  module.exports = {
    compile: compile,
    compileToFunction: compileToFunction
  };

}).call(this);
