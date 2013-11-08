jex
===

Jex is a compiler that compiles scheme like language to javascript code.

usage example (in coffee script)
================================

    Jex = require 'jex'

    console.log Jex.compile """
      (block
        (def f (func (x) (if (gt x 1000) "big number" "small number")))
        (f 50)
      )
    """

Jex.compile will return an object that contains the compiled code as string and array of variables
the code uses, but not defines itself.

    { 
      code: '((f = (function(x) { return (gt(x, 1000))?("big number"):("small number"); })), f(50))',
      refs: [ 'gt' ] 
    }

If you want a callable javascript function instead of a code text, call `Jex.compileToFunction`. It
will return a javascript function object extended with field `argNames` which contains
the `refs` (see `Jex.compile` above).
