// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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