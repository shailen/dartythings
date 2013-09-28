import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:survey/models.dart';

@CustomTag('option-element')
class OptionElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable Option option = new Option();
  @observable String errorMessage = '';
  @observable int maxTextLength = Option.MAXTEXTLENGTH;

  checkForErrors(Event e, detail, Node sender) {
    e.preventDefault();
    if (option.text.length > Option.MAXTEXTLENGTH) {
      errorMessage = "This field must be less than ${Option.MAXTEXTLENGTH} "
          "characters";
    } else {
      errorMessage = "";
    }
  }
}
