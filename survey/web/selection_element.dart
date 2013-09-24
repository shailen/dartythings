import 'package:polymer/polymer.dart';
import 'package:survey/models.dart';

@CustomTag('selection-element')
class SelectionElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable List<Option> options;
  @observable bool multiple = true;
}
