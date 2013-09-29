import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('selection-element')
class SelectionElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;

  @observable List<String> values = toObservable([]);
  @observable List<int> selectedIndices = toObservable([]);
  @observable bool multi = false;

  inserted() {
    super.inserted();
    var root = getShadowRoot('selection-element');
    var items = root.queryAll('li');
    markSelected(items);
  }

  markSelected(items) {
    for (var i = 0; i < items.length; i++) {
      if (selectedIndices.contains(i)) {
        items[i].classes.add('selected');
      } else {
        items[i].classes.remove('selected');
      }
    }
  }

  makeSelection(Event e, var detail, Element sender) {
    e.preventDefault();
    var root = getShadowRoot('selection-element');
    var items = root.queryAll('li');
    var index = items.indexOf(sender);

    if (!multi && items.length > 1) {
      selectedIndices.clear();
      selectedIndices.add(index);
    } else {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    }

    markSelected(items);

    // TODO: put in own method.
    List<String> results = [];
    for (var index in selectedIndices) {
      results.add(values[index]);
    }
    dispatchEvent(new CustomEvent('selectionmade', detail: results));
  }
}