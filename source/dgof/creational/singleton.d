module dgof.creational.singleton;

class Singleton {
public:
  static Singleton get() { return _instance; }

private:
  static __gshared Singleton _instance;

  shared static this() {
    _instance = new Singleton;
  }
}

unittest {
  const s = Singleton.get;
  assert(s !is null);
  import core.thread;
  auto t = new Thread({ assert(Singleton.get is s); });
  t.start();
  t.join();
}
