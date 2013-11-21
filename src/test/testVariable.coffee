Jex = require '../../lib'
assert = require 'assert'

module.exports = () ->
  { code, refs } = Jex.compile 'x'
  assert.equal code, 'x', "variable compilation failed"
  assert.deepEqual refs, [ 'x' ], "variable compilation didn't export references"
