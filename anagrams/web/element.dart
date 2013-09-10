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
  @observable String foo = "fooooooo";

  void dragStartHandler(e) {
    print('dragStartHandler');
    e.target.style.opacity = '0.25';
    sourceElement = e.target;
    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('text/html', e.target.innerHtml);
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
    print(selection1);
    print(selection2);
    print(possibleWords);
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
    possibleWords = anagrams[index][random.nextInt(anagrams[index].length)];
    print(possibleWords);
    // TODO: always give the scrambled word
    var word = possibleWords[random.nextInt(possibleWords.length)];
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
        charDiv.onDragStart.listen(dragStartHandler);
        charDiv.onDragEnter.listen(dragEnterHandler);
        charDiv.onDragOver.listen(dragOverHandler);
        charDiv.onDragLeave.listen(dragLeaveHandler);
        charDiv.onDrop.listen(dropHandler);
        charDiv.onDragEnd.listen(dragEndHandler);
      });
    });
  }
}
