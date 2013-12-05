import 'package:polymer/polymer.dart';

class Person extends Object with ObservableMixin {
  @observable String name;
  Person(this.name);
}

@CustomTag("custom-element")
class CustomElement extends PolymerElement {
  @observable Person person = new Person('John');
}
