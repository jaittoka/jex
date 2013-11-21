Jex = require '../../lib'
assert = require 'assert'

module.exports = 
  testNumber: () ->
    { code } = Jex.compile '13.234'
    assert.equal code, '13.234'

  testBoolean: () ->
    { code } = Jex.compile 'false'
    assert.equal code, 'false'
    { code } = Jex.compile 'true'
    assert.equal code, 'true'

  testString: () ->
    { code } = Jex.compile '"foobar"'
    assert.equal code, '"foobar"'

  testArray: () ->
    { code } = Jex.compile ' [ "test"   3.14  true ] '
    assert.equal code, '[ "test", 3.14, true ]'
