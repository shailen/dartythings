import 'package:polymer/polymer.dart';
import 'package:survey/models.dart';

@CustomTag('option-element')
class OptionElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable Option option = new Option();
  @observable bool checked = false;

  inserted() {
    print(option.hashCode);
  }
}
