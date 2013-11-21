Jex = require '../../lib'
assert = require 'assert'

module.exports = 
  'or': () ->
    f = Jex.compileToFunction '(or false false)'
    assert.equal f(), false, '(or false false)'
    f = Jex.compileToFunction '(or false true)'
    assert.equal f(), true, '(or false true)'
    f = Jex.compileToFunction '(or true false)'
    assert.equal f(), true, '(or true false)'
    f = Jex.compileToFunction '(or true true)'
    assert.equal f(), true, '(or true true)'
  'orShortCircuit': () ->
    f = Jex.compileToFunction '(or true (f))'
    f () -> throw new Error "or shortcuircuit didnt' work"
  'and': () ->
    f = Jex.compileToFunction '(and false false)'
    assert.equal f(), false, '(and false false)'
    f = Jex.compileToFunction '(and false true)'
    assert.equal f(), false, '(and false true)'
    f = Jex.compileToFunction '(and true false)'
    assert.equal f(), false, '(and true false)'
    f = Jex.compileToFunction '(and true true)'
    assert.equal f(), true, '(and true true)'
  'andShortCircuit': () ->
    f = Jex.compileToFunction '(and false (f))'
    f () -> throw new Error "and shortcuircuit didnt' work"
