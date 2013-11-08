(function() {
  var Compiler, compile, compileToFunction, parse;

  parse = require('./parser');

  Compiler = require('./compiler');

  compile = function(str, opts) {
    var c;
    c = new Compiler(opts);
    return c.compile(parse(str));
  };

  compileToFunction = function(str, opts) {
    var c;
    c = new Compiler(opts);
    return c.compileToFunc(parse(str));
  };

  module.exports = {
    compile: compile,
    compileToFunction: compileToFunction
  };

}).call(this);
