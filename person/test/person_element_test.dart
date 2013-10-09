// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library person.test.person_element_test;

import 'dart:html';

import 'package:unittest/html_config.dart';
import 'package:unittest/mock.dart';
import 'package:unittest/unittest.dart';

import 'package:person/model.dart';
import 'package:person/person_element.dart';

class MockPerson extends Mock implements Person {}

void main() {
  useHtmlConfiguration();

  MockPerson mockPerson;
  PersonElement personElement;

  setUp(() {
    mockPerson = new MockPerson();
    personElement = new PersonElement();
  });

  group('validateUsername', () {
    test('when usernameIsValid is false', () {
      mockPerson.when(callsTo('get usernameIsValid')).thenReturn(false);
      personElement.person = mockPerson;
      personElement.validateUsername(new Event('anything'));
      expect(personElement.errorMessage, PersonElement.usernameErrorMessage);
    });

    test('when usernameIsValid is true', () {
      mockPerson.when(callsTo('get usernameIsValid')).thenReturn(true);
      personElement.person = mockPerson;
      personElement.validateUsername(new Event('anything'));
      expect(personElement.errorMessage, isEmpty);
    });
  });
}