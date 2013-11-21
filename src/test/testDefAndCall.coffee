Jex = require '../../lib'
assert = require 'assert'

module.exports = () ->
  f = Jex.compileToFunction """
    (block
      (def f (func (n) (if (gt n 3) 'big' 'small')))
      (f 4)
    )
  """
  assert.equal (f (a,b) -> a > b), 'big'
