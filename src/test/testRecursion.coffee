Jex = require '../../lib'
assert = require 'assert'

module.exports = () ->
  f = Jex.compileToFunction """
    (def fibo (func (n) (cond
      ( (eq n 1) 1 )
      ( (eq n 2) 1 )
      ( else (add (fibo (sub n 2)) (fibo (sub n 1))))
    )))
  """

  eq = (a,b) -> a is b
  sub = (a,b) -> a - b
  add = (a,b) -> a + b
  
  fibo = f eq, add, sub

  assert.equal fibo(1), 1
  assert.equal fibo(2), 1
  assert.equal fibo(3), 2
  assert.equal fibo(4), 3
  assert.equal fibo(5), 5
  assert.equal fibo(6), 8
  assert.equal fibo(7), 13
  

