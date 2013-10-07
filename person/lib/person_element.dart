library person.person_element;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:person/model.dart';

@CustomTag('person-element')
class PersonElement extends PolymerElement with ObservableMixin {
  static String error_message = "Use ${Person.MIN_USERNAME_LENGTH} - "
      "${Person.MAX_USERNAME_LENGTH} lowercase letters only";
  bool get applyAuthorStyles => true;

  @observable String username = "";
  @observable Person person = new Person();
  @observable String errorMessage = '';
  @observable bool showTOS = false;
  @observable bool hasCheckedTOS = false;

  void validateUsername(Event e) {
    print('>>>>>>>>>>> running validation >>>>>>>>>>>>');
    print('username = ${username}');
    print(e.target.value);
    e.preventDefault();
    if (username.length > 2 && username.length < 8) {
      errorMessage = '';
    } else {
      errorMessage = error_message;
    }
  }

  void showTOSPanel() {
    if (username.length > 2 && username.length < 8) {
      showTOS = true;
    }
  }

  foo() {
    window.alert('foo');
  }
}

