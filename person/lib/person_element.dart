library person.person_element;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:person/model.dart';

@CustomTag('person-element')
class PersonElement extends PolymerElement with ObservableMixin {
  static String error_message = "Use ${Person.MIN_USERNAME_LENGTH} - "
      "${Person.MAX_USERNAME_LENGTH} lowercase letters only";

  bool get applyAuthorStyles => true;

  @observable Person person = new Person();
  @observable String errorMessage = '';
  @observable bool showTOS = false;
  @observable bool hasCheckedTOS = false;

  bool validateUsername(Event e) {
    e.preventDefault();
    if (person.usernameIsValid) {
      errorMessage = '';
      return true;
    } else {
      errorMessage = error_message;
      return false;
    }
  }

  void showTOSPanel(Event e) {
    if (validateUsername(e)) {
      showTOS = true;
    }
  }
}

