import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'anagrams.dart';

@CustomTag("word-element")
class WordElement extends PolymerElement with ObservableMixin {
  @observable List<String> chars1 = toObservable([]);
  @observable List<String> chars2 = toObservable([]);
  @observable String selection1;
  @observable String selection2;
  Element sourceElement;
  List<DivElement> charDivs;
  List<String> possibleWords = [];
  @observable List<String> selectedWords = toObservable([]);
  @observable int score = 0;

  void dragStartHandler(e) {
    print('dragStartHandler');
    e.target.style.opacity = '.25';
    sourceElement = e.target;
    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('text/html', e.target.innerHtml);
  }

  void touchStartHandler(e) {
    e.target.style.opacity = '.25';
    sourceElement = e.target;
  }

  void dragEnterHandler(e) {
    print('dragEnterHandler');
    e.target.classes.add('over');
  }

  void dragOverHandler(e) {

    e.preventDefault();
    e.dataTransfer.dropEffect = 'move';
  }

  void dragLeaveHandler(e) {
    print('dragLeaveHandler');
    e.target.classes.remove('over');
  }

  void dropHandler(e) {
    e.stopPropagation();
    print('dropHandler');
    if (sourceElement != e.target) {
      sourceElement.innerHtml = e.target.innerHtml;
      e.target.innerHtml = e.dataTransfer.getData('text/html');
    }
  }

  void touchEndHandler(e) {
    e.stopPropagation();
    if (sourceElement != e.target) {
      sourceElement.innerHtml = e.target.innerHtml;
    }
  }

  void dragEndHandler(e) {
    e.preventDefault();
    e.stopPropagation();

    print('dragEndHandler');
    StringBuffer sb = new StringBuffer();
    for (var i = 0; i < charDivs.length; i++) {
      charDivs[i].classes.remove('over');
      sb.write(charDivs[i].text);
    }
    e.target.style.opacity = '1.0';
    var temp = sb.toString();
    selection2 = temp.substring(temp.length ~/ 2, temp.length);
    selection1 = temp.substring(0, temp.length ~/ 2);
    print('selection1 = $selection1');
    print('selection2 = $selection2');
    print('chars1 = $chars1');
    print('chars2 = $chars2');
    [selection1, selection2].forEach((selection) {
      var word = selection.trim();
      if (possibleWords.contains(word)) {
        if (!selectedWords.contains(word)) {
          selectedWords.add(word);
          score += word.length;
          print(score);
        }
      }
    });
  }

  void created() {
    super.created();
    var random = new Random();
    var highAnagramIndices = [8, 9, 10, 11, 12];
    var index = highAnagramIndices[random.nextInt(highAnagramIndices.length)];
    // TODO: refactor
    possibleWords = ['least', 'setal', 'slate', 'stale', 'steal', 'stela', 'taels', 'tales',
                     'teals', 'tesla', 'ae', 'al', 'as', 'at', 'el', 'es', 'et', 'la', 'ta', 'ale',
                     'als', 'alt', 'ate', 'eat', 'els', 'eta', 'las', 'lat', 'lea', 'les', 'let',
                     'sae', 'sal', 'sat', 'sea', 'sel', 'set', 'tae', 'tas', 'tea', 'tel', 'ales',
                     'alts', 'ates', 'east', 'eats', 'etas', 'lase', 'last', 'late', 'lats',
                     'leas', 'lest', 'lets', 'sale', 'salt', 'sate', 'seal', 'seat', 'seta',
                     'slat', 'tael', 'tale', 'teal', 'teas', 'tela', 'tels'];
    print(possibleWords);
    var word = possibleWords.first;
    for (var i = 0; i < word.length; i++) {
      chars2.add(' ');
    }
    print(word);
    print(possibleWords);
    chars1.addAll(word.split(''));
    selection1 = word;
  }

  inserted() {
    new Timer(new Duration(milliseconds: 500), () {
      charDivs = this.shadowRoot.queryAll('.char');
      charDivs.forEach((charDiv) {
        charDiv.onTouchStart.listen(touchStartHandler);
        charDiv.onDragStart.listen(dragStartHandler);

        charDiv.onDragEnter.listen(dragEnterHandler);

        charDiv.onDragOver.listen(dragOverHandler);

        charDiv.onDragLeave.listen(dragLeaveHandler);

        charDiv.onDrop.listen(dropHandler);
        charDiv.onTouchEnd.listen(touchEndHandler);

        charDiv.onDragEnd.listen(dragEndHandler);
      });
    });
  }
}
