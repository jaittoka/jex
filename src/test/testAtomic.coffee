Jex = require '../../lib'
assert = require 'assert'

module.exports = 
  testNumber: () ->
    { code } = Jex.compile '13.234'
    assert.equal code, '13.234', 'Compilation of number failed'

  testBoolean: () ->
    { code } = Jex.compile 'false'
    assert.equal code, 'false', 'Compilation of boolean false failed'
    { code } = Jex.compile 'true'
    assert.equal code, 'true', 'Compilation of boolean true failed'

  testString: () ->
    { code } = Jex.compile '"foobar"'
    assert.equal code, '"foobar"', 'Compilation of string failed'

  testArray: () ->
    { code } = Jex.compile ' [ "test"   3.14  true ] '
    assert.equal code, '[ "test", 3.14, true ]', 'Compilation of string failed'
