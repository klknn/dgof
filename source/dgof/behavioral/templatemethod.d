// This module only contains example of template method pattern.
module dgof.behavioral.templatemethod;

import std.string : strip;

abstract class AbstractDisplay {
public:
  // Template method.
  final string display() {
    string s;
    s ~= open();
    foreach (_; 0 .. 5) {
      s ~= print();
    }
    s ~= close();
    return s;
  }

  // Subclass is responsible for overriding these methods.
  string open();
  string print();
  string close();
}

class CharDisplay : AbstractDisplay {
public:
  this(char c) { _c = c; }
  override string open() { return "<<"; }
  override string print() { return [_c]; }
  override string close() { return ">>"; }

private:
  char _c;
}

unittest {
  AbstractDisplay d = new CharDisplay('H');
  assert(d.display == "<<HHHHH>>");
}

class StringDisplay : AbstractDisplay {
public:
  this(string s) {
    _s = s;
  }

  override string open() {
    string s = "+";
    foreach (_; _s) {
      s ~= "-";
    }
    return s ~ "+\n";
  }

  override string print() {
    return "|" ~ _s ~ "|\n";
  }

  override string close() { return open(); }

private:
  string _s;
}

unittest {
  AbstractDisplay d = new StringDisplay("Hello, world.");
  assert(d.display.strip == `
+-------------+
|Hello, world.|
|Hello, world.|
|Hello, world.|
|Hello, world.|
|Hello, world.|
+-------------+`.strip);
}
