parse = require './parser'
Compiler = require './compiler'

compile = (str, opts) ->
  c = new Compiler opts
  c.compile parse str

compileToFunction = (str, opts) ->
  c = new Compiler opts
  c.compileToFunc parse str

module.exports = {
  compile
  compileToFunction
}
