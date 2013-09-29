import 'dart:html';
import 'package:polymer/polymer.dart';

class Char {
  int position;
  String value;
  Char(this.position, this.value);
  String toString() => '[$position, $value]';
}

@CustomTag("word-element")
class WordElement extends PolymerElement with ObservableMixin {
  // bool get applyAuthorStyles => true;
  @observable List<Char> charsList;

  // Get rid of all these lists.  Use charsList as the single canonical list.
  // Use getters.
  @observable List<Char> chars1;
  @observable List<Char> chars2;
  @observable List<List<Char>> lists;

  @observable int score = 0;
  List<String> possibleWords = [];
  List<String> formedWords = [];

  int sourceElementIndex;
  int targetElementIndex;
  @observable String word;

  String upCase(String str) => str.toUpperCase();

  get firstSubList => (list) => [list.getRange(0, word.length).toList()];
  get secondSubList => (list) => [list.getRange(word.length, list.length).toList()];

  created() {
    super.created();
    possibleWords = toObservable(['least', 'setal', 'slate', 'stale', 'steal', 'stela', 'taels', 'tales',
                     'teals', 'tesla', 'ae', 'al', 'as', 'at', 'el', 'es', 'et', 'la', 'ta', 'ale',
                     'als', 'alt', 'ate', 'eat', 'els', 'eta', 'las', 'lat', 'lea', 'les', 'let',
                     'sae', 'sal', 'sat', 'sea', 'sel', 'set', 'tae', 'tas', 'tea', 'tel', 'ales',
                     'alts', 'ates', 'east', 'eats', 'etas', 'lase', 'last', 'late', 'lats',
                     'leas', 'lest', 'lets', 'sale', 'salt', 'sate', 'seal', 'seat', 'seta',
                     'slat', 'tael', 'tale', 'teal', 'teas', 'tela', 'tels']);

    word = possibleWords.first;

    charsList = toObservable(new List(word.length * 2));

    // TODO: sprinkle words over both rows.
    for (var i = 0; i < word.length; i++) {
      charsList[i] = new Char(i, word[i]);
      var blank = i + word.length;
      charsList[blank] = new Char(blank, ' ');
    }

    chars1 = toObservable(new List(word.length));
    chars2 = toObservable(new List(word.length));
    _filterChars();
    lists = toObservable([chars1, chars2]);
  }

  _filterChars() {
    for (var i = 0; i < word.length; i++) {
      chars1[i] = charsList[i];
      chars2[i] = charsList[i + word.length];
    }
  }


  void dragStartHandler(Event e, detail, sender) {
    e.target.style.opacity = '.25';
    sourceElementIndex = int.parse(e.target.attributes['position']);
  }

  void dragEnterHandler(e) {
    e.target.classes.add('over');
  }

  void dragOverHandler(e) {
    e.preventDefault();
    e.dataTransfer.dropEffect = 'move';
  }

  void dragLeaveHandler(e) {
    e.target.classes.remove('over');
  }

  void dropHandler(Event e) {
    e.preventDefault();
    targetElementIndex = int.parse(e.target.attributes['position']);
    var temp = charsList[sourceElementIndex].value;
    charsList[sourceElementIndex].value = charsList[targetElementIndex].value;
    charsList[targetElementIndex].value = temp;
    _filterChars();
  }

  void dragEndHandler(Event e, detail, sender) {
    e.preventDefault();
    e.stopPropagation();
    e.target.style.opacity = '1.0';
    var words = [];
    [chars1, chars2].forEach((chars) {
      var tokens = chars.map((char) => char.value).toList();
      var fragments = tokens.join('').split(' ').where(
          (token) => token.trim().isNotEmpty).toList();
      words.addAll(fragments);
    });

    for (var w in words) {
      if (possibleWords.contains(w)) {
        if (!formedWords.contains(w)) {
          formedWords.add(w);
          score += w.length;
        }
      }
    }
  }
}
