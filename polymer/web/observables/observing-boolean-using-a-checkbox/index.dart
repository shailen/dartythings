import 'dart:html';
import 'package:polymer/polymer.dart';

@observable
class Task {
  bool isDone = false;
}

void main() {
  query("#_template").model = new Task();
}