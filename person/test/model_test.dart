// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library person.test.model_test;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

import 'package:person/model.dart';

String _stringOfLength(int len) {
  return new List.filled(len, 'x').join('');
}

void main() {
  useHtmlConfiguration();

  group('usernameIsValid', () {
    test('when object is created', () {
      var person = new Person();
      expect(person.usernameIsValid, isFalse);
    });

    test('min username length', () {
      var person = new Person();
      person.username = _stringOfLength(Person.MIN_USERNAME_LENGTH - 1);
      expect(person.usernameIsValid, isFalse);
      person.username = _stringOfLength(Person.MIN_USERNAME_LENGTH);
      expect(person.usernameIsValid, isTrue);
    });

    test('max username length', () {
      var person = new Person();
      person.username = _stringOfLength(Person.MAX_USERNAME_LENGTH);
      expect(person.usernameIsValid, isTrue);
      person.username = _stringOfLength(Person.MAX_USERNAME_LENGTH + 1);
      expect(person.usernameIsValid, isFalse);
    });
  });
}