import 'dart:html';
import 'package:polymer/polymer.dart';


@CustomTag('selection-element')
class SelectionElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;

  // TODO: have parent pass in the values.
  @observable List<String> values = toObservable(['male', 'female']);
  @observable int selected = 0;


  inserted() {
    super.inserted();
    var root = getShadowRoot('selection-element');
    var item = root.queryAll('li')[selected];
    item.classes.toggle('selected');
  }

  makeSelection(Event e, var detail, Element sender) {
    e.preventDefault();
    List items = sender.parent.children;
    items.forEach((var li) {
      li.classes.toggle('selected');
    });
  }
}
