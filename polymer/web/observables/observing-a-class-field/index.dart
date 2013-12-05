import 'dart:html';
import 'package:polymer/polymer.dart';

class Person extends Object with ObservableMixin {
  @observable
  String name;
  Person(this.name);
}

main() {
  query("#_template").model = new Person('Bob');
}