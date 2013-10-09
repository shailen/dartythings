// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


import 'dart:html';

import 'package:unittest/html_config.dart';
import 'package:unittest/mock.dart';
import 'package:unittest/unittest.dart';

import 'package:registration/model.dart';
import 'package:registration/registration_element.dart';

class MockUser extends Mock implements User {}

void main() {
  useHtmlConfiguration();

  MockUser mockUser;
  RegistrationElement registrationElement;

  setUp(() {
    mockUser = new MockUser();
    registrationElement = new RegistrationElement();
  });

  group('validateUsername', () {
    test('when usernameIsValid is false', () {
      mockUser.when(callsTo('get usernameIsValid')).thenReturn(false);
      registrationElement.user = mockUser;
      registrationElement.validateUsername(new Event('anything'));
      expect(registrationElement.errorMessage,
          RegistrationElement.usernameErrorMessage);
    });

    test('when usernameIsValid is true', () {
      mockUser.when(callsTo('get usernameIsValid')).thenReturn(true);
      registrationElement.user = mockUser;
      registrationElement.validateUsername(new Event('anything'));
      expect(registrationElement.errorMessage, isEmpty);
    });
  });
}
