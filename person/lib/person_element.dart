library person.person_element;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:person/model.dart';

// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@CustomTag('person-element')
class PersonElement extends PolymerElement with ObservableMixin {
  static String usernameErrorMessage = 'Use ${Person.MIN_USERNAME_LENGTH} - '
      '${Person.MAX_USERNAME_LENGTH} lowercase letters only';

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
      errorMessage = usernameErrorMessage;
      return false;
    }
  }

  void showTOSPanel(Event e) {
    if (validateUsername(e)) {
      showTOS = true;
    }
  }
}

