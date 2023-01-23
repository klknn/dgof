// This module only contains example of template factory pattern.
module dgof.creational.factorymethod;

abstract class ProductFactory {
public:
  // Factory method.
  Product create(string owner) {
    Product p = createProduct(owner);
    registerProduct(p);
    return p;
  }

protected:
  Product createProduct(string owner);
  void registerProduct(Product p);
}

interface Product {
public:
  void use();
}

class IDCard : Product {
public:
  this(string owner) { _owner = owner; }
  override void use() { _used = true; }

private:
  string _owner;
  bool _used;
}

class IDCardFactory : ProductFactory {
protected:
  override Product createProduct(string owner) { return new IDCard(owner); }
  override void registerProduct(Product p) { _owners ~= (cast(IDCard) p)._owner; }
private:
  string[] _owners;
}

unittest {
  IDCardFactory f = new IDCardFactory;
  Product p1 = f.create("foo");
  Product p2 = f.create("bar");
  assert(f._owners == ["foo", "bar"]);
}
