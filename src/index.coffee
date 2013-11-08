parse = require './parser'
Compiler = require './compiler'

compile = (str) ->
  c = new Compiler
  c.compile parse str

compileToFunction = (str) ->
  c = new Compiler
  c.compileToFunc parse str

module.exports = {
  compile
  compileToFunction
}
