import 'package:mdv/mdv.dart' as mdv;
import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';


class Counter extends ObservableBase{
  int count = 0;
  void increment() {
    notifyPropertyChange(const Symbol('count'), count, ++count);
  }
}

void main() {
  mdv.initialize();
  var counter = new Counter();
  var elem = query('#counter');
  elem.model = counter;
  new Timer.periodic(const Duration(seconds: 1), (_) => counter.increment());
}

