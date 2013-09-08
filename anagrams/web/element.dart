import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'anagrams.dart';

@CustomTag("word-element")
class WordElement extends PolymerElement with ObservableMixin {
  @observable List chars = toObservable([]);
  Element sourceElement;
  List<DivElement> charDivs;
  String sourceChar;
  String destinationChar;

  void dragStartHandler(e) {
    print('dragStartHandler');
    e.target.style.opacity = '0.25';
    sourceElement = e.target;
    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('text/html', e.target.innerHtml);
    sourceChar = e.target.text;
    print(chars);
  }

  void dragEnterHandler(e) {
    print('dragEnterHandler');
    e.target.classes.add('over');
  }

  void dragOverHandler(e) {
    print('dragOverHandler');
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
    print('dragEndHandler');
    for (var i = 0; i < charDivs.length; i++) {
      charDivs[i].classes.remove('over');
      print("*********" + charDivs[i].text);
    }
    e.target.style.opacity = '1.0';
    print(chars);
  }

  void created() {
    super.created();
    var random = new Random();
    var highAnagramIndices = [9, 10, 11, 12];
    var index = highAnagramIndices[random.nextInt(highAnagramIndices.length)];
    var wordList = anagrams[index][random.nextInt(anagrams[index].length)];
    var word = wordList[random.nextInt(wordList.length)];
    print(word);
    chars.addAll(word.split(''));
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

