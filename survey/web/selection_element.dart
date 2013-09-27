import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('selection-element')
class SelectionElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;

  @observable List<String> values = toObservable(['red', 'green', 'blue']);
  @observable List<int> selectedIndices = toObservable([1]);
  @observable List<String> selectedValues = toObservable([]);
  @observable bool multi = false;

  created() {
    super.created();
  }

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

    if (!multi) {
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
    dispatchEvent(new CustomEvent('selectionmade', detail: ['f', 'g']));
  }
}
