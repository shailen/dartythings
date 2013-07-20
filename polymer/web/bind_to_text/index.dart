import 'package:mdv/mdv.dart' as mdv;
import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';

class Text extends ObservableBase {
  List<String> words = toObservable(['Fee', 'Fi', 'Fo', 'Fum']);

  void rotate() {
    List<String> oldWords = new List.from(words);
    words.add(words.removeAt(0));
    words = notifyPropertyChange(const Symbol('options'), oldWords, words);
  }
}

void main() {
  mdv.initialize();
  var text = new Text();
  var elem = query('#text');
  elem.model = text;
  query('#rotateText').onClick.listen((event) => text.rotate());
}
