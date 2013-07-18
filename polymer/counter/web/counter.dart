import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:observe/observe.dart';

class Counter extends CustomElement with ObservableMixin {
  @observable int counter = 0;

  void inserted() {
    new Timer.periodic(const Duration(seconds: 1), (_) => counter++);
  }
}