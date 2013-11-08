module.exports = (args, c) ->  
  throw new Error "Definition expects an identifier as first argument" if not c.isIdentifier args[0]
  "(#{c.define args[0].value, false} = #{c.compileNode args[1]})"
