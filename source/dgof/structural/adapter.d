// This module only contains example of adapter pattern.
module dgof.structural.adapter;

class LegacyPrinter {
public:
  this(string s) { _s = s; }
  string paren() { return "(" ~ _s ~ ")"; }
  string asterisk() { return "*" ~ _s ~ "*"; }

private:
  string _s;
}

interface NewPrinter {
  string weak();
  string strong();
}

class InheritancePrinterAdapter : LegacyPrinter, NewPrinter {
public:
  this(string s) { super(s); }
  override string weak() { return paren(); }
  override string strong() { return asterisk(); }
}

unittest {
  NewPrinter p = new InheritancePrinterAdapter("foo");
  assert(p.weak == "(foo)");
  assert(p.strong == "*foo*");
}

class FieldPrinterAdapter : NewPrinter {
public:
  this(string s) { _printer = new LegacyPrinter(s); }
  override string weak() { return _printer.paren; }
  override string strong() { return _printer.asterisk; }

private:
  LegacyPrinter _printer;
}

unittest {
  NewPrinter p = new FieldPrinterAdapter("foo");
  assert(p.weak == "(foo)");
  assert(p.strong == "*foo*");
}
