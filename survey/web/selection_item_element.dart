import 'package:polymer/polymer.dart';


@CustomTag('selection-item-element')
class SelectionItemElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;

  @observable String value = '';
  @observable bool checked = false;
}
