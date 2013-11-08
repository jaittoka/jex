jex
===

Jex is a compiler that compiles scheme like language to javascript code.

Usage example (in coffee script)
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

Source syntax
=============

exp -> apply | atomic
apply -> '(' func param+ ')'
atomic -> true | false | number | string | identifier

Apply
=====
If `func` is an identifier and its value equals to one of the compiler builtins (below), 
then it apply is compiled with corrseponding builtin compiler. Otherwise it
is compiled as a user function invocation.

Supported compiler builtins
===========================

array
----- 
An array. 

    (array 2 3 4)

There is also a syntactic helper for this: `[ 2 3 4 ]`

and
---
Logical and (&&)

    (and false true)

or
--
Logical or (||)

    (or false true)

block
-----
List of expressions. Value of a block is the value of the last expression.

    (block x y z)

def
---
Variable definition

    (def x 3)

func
----
A function closure (lamda)

    (def mul2 (func (x) (mul 2 x)))

if
--
If expression

    (if (lt x 2) (add x 2) x)

 