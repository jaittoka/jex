Jex = require '../../lib'
assert = require 'assert'

module.exports = () ->
  { code } = Jex.compile '(def x 15)'
  assert.equal code, '(x = 15)'
