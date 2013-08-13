import 'dart:html';

class Book {
  String title;
  Author author;
  Book(this.title, this.author);
}

class Author {
  String name;
  Author(this.name);
}

main() {
  query('#book').model = new Book('War and Peace', new Author('Leo Tolstoy'));
}
