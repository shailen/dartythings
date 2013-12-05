import 'dart:html';

class Person {
  String name;
  Person(this.name);
}

main() {
  // Get a DOM element and assign it a model.
  query('#greeting').model = new Person('John');
}