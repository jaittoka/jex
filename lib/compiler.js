(function() {
  var Compiler, Identifier, compilers;

  Identifier = require('./runtime').Identifier;

  compilers = {
    'apply': require('./compilers/compileApply'),
    'var': require('./compilers/compileVar'),
    'array': require('./compilers/compileArray'),
    'and': require('./compilers/compileAnd'),
    'block': require('./compilers/compileBlock'),
    'def': require('./compilers/compileDef'),
    'func': require('./compilers/compileFunc'),
    'if': require('./compilers/compileIf'),
    'or': require('./compilers/compileOr')
  };

  module.exports = Compiler = (function() {
    function Compiler(opts) {
      this.opts = opts != null ? opts : {};
    }

    Compiler.prototype.pushScope = function() {
      return this.scopes.push({
        defs: {},
        refs: {}
      });
    };

    Compiler.prototype.popScope = function() {
      var isLocal, name, _ref;
      _ref = this.scopes[this.scopes.length - 1].refs;
      for (name in _ref) {
        isLocal = _ref[name];
        if (!isLocal) {
          this.globals[name] = true;
        }
      }
      return this.scopes.pop();
    };

    Compiler.prototype.define = function(name, isArg) {
      if (this.scopes[this.scopes.length - 1].defs[name] != null) {
        throw new Error("Re-definition of variable " + name);
      }
      this.scopes[this.scopes.length - 1].defs[name] = isArg;
      return name;
    };

    Compiler.prototype.globalAccess = function(name) {
      if (typeof this.opts.global === 'function') {
        return this.opts.global(name);
      } else {
        return name;
      }
    };

    Compiler.prototype.ref = function(name) {
      if (this.isDefined(name)) {
        this.scopes[this.scopes.length - 1].refs[name] = true;
        return name;
      } else {
        this.scopes[this.scopes.length - 1].refs[name] = false;
        return this.globalAccess(name);
      }
    };

    Compiler.prototype.isDefined = function(name) {
      var l, s;
      l = s = this.scopes.length - 1;
      while (s >= 0) {
        if (this.scopes[s--].defs[name] != null) {
          return true;
        }
      }
      return false;
    };

    Compiler.prototype.getLocals = function() {
      var isArg, name, _ref, _results;
      _ref = this.scopes[this.scopes.length - 1].defs;
      _results = [];
      for (name in _ref) {
        isArg = _ref[name];
        if (!isArg) {
          _results.push(name);
        }
      }
      return _results;
    };

    Compiler.prototype.isIdArray = function(a) {
      var v, _i, _len;
      if (!this.isArray(a)) {
        return false;
      }
      for (_i = 0, _len = a.length; _i < _len; _i++) {
        v = a[_i];
        if (!this.isIdentifier(v)) {
          return false;
        }
      }
      return true;
    };

    Compiler.prototype.isArray = function(a) {
      return typeof a === 'object' && a.constructor === Array;
    };

    Compiler.prototype.isIdentifier = function(v) {
      return v instanceof Identifier;
    };

    Compiler.prototype.compileApply = function(arr) {
      var compiler;
      if (this.isIdentifier(arr[0])) {
        compiler = compilers[arr[0].value];
        if (compiler != null) {
          return compiler(arr.slice(1), this);
        }
      }
      return compilers['apply'](arr, this);
    };

    Compiler.prototype.compileNode = function(node) {
      if (node === null) {
        return 'null';
      }
      if (this.isIdentifier(node)) {
        return compilers['var'](node.value, this);
      }
      if (this.isArray(node)) {
        return this.compileApply(node);
      } else {
        return JSON.stringify(node);
      }
    };

    Compiler.prototype.compile = function(node) {
      var name, res, _;
      this.scopes = [];
      this.globals = {};
      this.pushScope();
      res = this.compileNode(node);
      this.popScope();
      return {
        code: res,
        refs: (function() {
          var _ref, _results;
          _ref = this.globals;
          _results = [];
          for (name in _ref) {
            _ = _ref[name];
            _results.push(name);
          }
          return _results;
        }).call(this)
      };
    };

    Compiler.prototype.compileToFunc = function(node) {
      var code, f, refs, _ref;
      _ref = this.compile(node), code = _ref.code, refs = _ref.refs;
      f = new Function(refs, "return " + code + ";");
      f.argNames = refs;
      return f;
    };

    return Compiler;

  })();

}).call(this);
