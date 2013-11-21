class Input
  constructor: (@str) ->
    @len = str.length
    @pos = 0

  hasMore: () -> @pos < @len

  peek: (n) -> 
    i = @pos + n
    @str.charAt i if i < @len

  inc: () -> @pos++

  advance: (f) -> 
    while @pos < @len and f @str.charAt @pos 
      @pos++

  get: () -> @str.substring @start, @pos

  save: () ->  @start = @pos

  restore: () -> @pos = @start

module.exports = Input  

