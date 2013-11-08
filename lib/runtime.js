(function() {
  var Identifier, identifier;

  Identifier = (function() {
    function Identifier(value) {
      this.value = value;
    }

    return Identifier;

  })();

  identifier = function(value) {
    return new Identifier(value);
  };

  module.exports = {
    Identifier: Identifier,
    identifier: identifier
  };

}).call(this);
