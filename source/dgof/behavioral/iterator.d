module dgof.behavioral.iterator;

interface Iterator(Item) {
public:
  bool hasNext();
  Item next();
}

interface Aggregate(Item) {
public:
  Iterator!Item iterator();
}

unittest {
  struct Book {
    string name;
  }

  class BookShelf : Aggregate!Book {
  public:
    void append(Book book) { _books ~= book; }

    override Iterator!Book iterator() {
      return new class Iterator!Book {
      public:
        override bool hasNext() {
          return index < this.outer._books.length;
        }

        override Book next() {
          return this.outer._books[index++];
        }
      private:
        int index;
      };
    }

  private:
    Book[] _books;
  }

  auto shelf = new BookShelf;
  shelf.append(Book("foo"));
  shelf.append(Book("bar"));

  Book[] books;
  for (Iterator!Book iter = shelf.iterator; iter.hasNext();) {
    books ~= iter.next();
  }
  assert(books == [Book("foo"), Book("bar")]);
}
