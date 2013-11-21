Jex = require '../../lib'
assert = require 'assert'

module.exports = () ->
  f = Jex.compileToFunction '( (func (x y) (or x y)) false true )'
  assert.equal f(), true, 'failure'

