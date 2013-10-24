import 'package:polymer/polymer.dart';

@CustomTag('my-app')
class MyApp extends PolymerElement {
  @observable bool applyAuthorStyles = true;
  final List<String> fruits = ['Apple', 'Banana', 'Guava', 'Kumquat',
                               'Mango','Peach', 'Pineapple', 'Pluat',
                               'Plum'];

  MyApp.created() : super.created() {}
}