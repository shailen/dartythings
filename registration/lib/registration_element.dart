import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:registration/model.dart';

// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@CustomTag('registration-element')
class RegistrationElement extends PolymerElement with ObservableMixin {
  static String usernameErrorMessage = 'Use ${User.MIN_USERNAME_LENGTH} - '
      '${User.MAX_USERNAME_LENGTH} lowercase letters only';

  bool get applyAuthorStyles => true;

  @observable User user = new User();
  @observable String errorMessage = '';
  @observable bool showTOS = false;
  @observable bool hasCheckedTOS = false;

  bool validateUsername(Event e) {
    e.preventDefault();
    if (user.usernameIsValid) {
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

