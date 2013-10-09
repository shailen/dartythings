library person.model;

import 'package:polymer/polymer.dart';

class Person extends ObservableBase {
  static const int MIN_USERNAME_LENGTH = 3;
  static const int MAX_USERNAME_LENGTH = 8;

  @observable String username = '';
  @observable bool hasCheckedTOS = false;

  bool get usernameIsValid {
    return new RegExp('^[a-z]{$MIN_USERNAME_LENGTH,$MAX_USERNAME_LENGTH}\$')
        .hasMatch(username);
  }
}