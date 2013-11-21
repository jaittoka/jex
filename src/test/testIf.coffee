Jex = require '../../lib'
assert = require 'assert'

module.exports = 
  'testTrue': () ->
    f = Jex.compileToFunction '(if true 1 2)'
    assert.equal f(), 1, 'true condition didn\' work'
  'testFalse': () ->
    f = Jex.compileToFunction '(if false 1 2)'
    assert.equal f(), 2, 'false condition didn\' work'
