import 'dart:html';

class Person {
  String name;
  bool isNice;
  Person(this.name, this.isNice);
}

void main() {
  query('#person').model = new Person('Kathy', true);
}