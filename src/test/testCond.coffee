Jex = require '../../lib'
assert = require 'assert'

module.exports = 
  'withElse': () ->
    f = Jex.compileToFunction """
      (cond 
        ((eq x 1) 'small')
        ((eq x 2) 'medium')
        (else 'big')
      )
    """
    eq = (a, b) -> a == b
    assert.equal f(eq, 1), 'small'
    assert.equal f(eq, 2), 'medium'
    assert.equal f(eq, 3), 'big'
    assert.equal f(eq, 4), 'big'
    assert.equal f(eq, -1), 'big'

  'withoutElse': () ->
    f = Jex.compileToFunction """
      (cond 
        ((eq x 1) 'small')
        ((eq x 2) 'medium')
      )
    """
    eq = (a, b) -> a == b

    assert.equal f(eq, 1), 'small'
    assert.equal f(eq, 2), 'medium'
    assert.equal f(eq, 3), undefined
    assert.equal f(eq, -1), undefined