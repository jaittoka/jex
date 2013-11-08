class Identifier
  constructor: (@value) ->

identifier = (value) -> new Identifier value

module.exports = {
  Identifier
  identifier
}