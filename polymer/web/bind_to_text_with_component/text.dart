import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:observe/observe.dart';

class Text extends PolymerElement with ObservableMixin {
  List<String> words = toObservable(['Fee', 'Fi', 'Fo', 'Fum']);

  void rotate(event, detail, target) {
    words.add(words.removeAt(0));
  }
}