// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

import 'package:registration/model.dart';

String _stringOfLength(int len) {
  return new List.filled(len, 'x').join('');
}

void main() {
  useHtmlConfiguration();

  group('usernameIsValid', () {
    test('when object is created', () {
      var user = new User();
      expect(user.usernameIsValid, isFalse);
    });

    test('min username length', () {
      var user = new User();
      user.username = _stringOfLength(User.MIN_USERNAME_LENGTH - 1);
      expect(user.usernameIsValid, isFalse);
      user.username = _stringOfLength(User.MIN_USERNAME_LENGTH);
      expect(user.usernameIsValid, isTrue);
    });

    test('max username length', () {
      var user = new User();
      user.username = _stringOfLength(User.MAX_USERNAME_LENGTH);
      expect(user.usernameIsValid, isTrue);
      user.username = _stringOfLength(User.MAX_USERNAME_LENGTH + 1);
      expect(user.usernameIsValid, isFalse);
    });
  });
}
