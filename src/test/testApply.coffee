Jex = require '../../lib'
assert = require 'assert'

module.exports = () ->
  f = Jex.compileToFunction '(f 3)'
  res = f (v) -> v + 1
  assert.equal res, 4

