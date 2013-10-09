// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'package:registration/model.dart';
import 'package:registration/registration_element.dart';

ShadowRoot shadowRoot;

const VALID_USERNAME = 'xyz';
const INVALID_USERNAME = '';
const REGISTRATION_ELEMENT = 'registration-element';
const USERNAME_INPUT = '#username-input';
const NEXT_BUTTON = '#next-button';
const HAS_CHECKED_TOS_INPUT = '#has-checked-tos-input';
const ERROR_MESSAGE_DIV = '#error-message-div';
const SUCCESS_MESSAGE_DIV =  '#success-message-div';

void fillUsername(String value) {
  (shadowRoot.query(USERNAME_INPUT) as InputElement)
      ..value = value
      ..dispatchEvent(new KeyboardEvent('input'))
      ..dispatchEvent(new KeyboardEvent('keyup'));
  performMicrotaskCheckpoint();
}

pressNextButton() {
  shadowRoot.query(NEXT_BUTTON).click();
  performMicrotaskCheckpoint();
}

checkTOSCheckbox() {
  shadowRoot.query(HAS_CHECKED_TOS_INPUT).dispatchEvent(
      new MouseEvent('click', detail: 1));
  performMicrotaskCheckpoint();
}

expectNoErrorMessage() {
  expect(shadowRoot.query(ERROR_MESSAGE_DIV).text, isEmpty);
}

expectErrorMessage() {
  var minLen = User.MIN_USERNAME_LENGTH;
  var maxLen = User.MAX_USERNAME_LENGTH;
  expect(shadowRoot.query(ERROR_MESSAGE_DIV).text,
      RegistrationElement.usernameErrorMessage);
}

expectRendered(String elementID) {
  expect(shadowRoot.query(elementID), isNotNull);
}

expectNotRendered(String elementID) {
  expect(shadowRoot.query(elementID), isNull);
}

main() {
  useHtmlConfiguration();

  setUp(() {
    document.body.children.add(createElement(REGISTRATION_ELEMENT));
    performMicrotaskCheckpoint();
    shadowRoot = query(REGISTRATION_ELEMENT).shadowRoot;
  });

  tearDown(() {
    var el = document.body.query(REGISTRATION_ELEMENT);
    if (el != null) {
      document.body.children.remove(el);
    }
  });

  test('initial state', () {
    expectNoErrorMessage();
    expect(shadowRoot.query(HAS_CHECKED_TOS_INPUT), isNull);
    expect(shadowRoot.query(SUCCESS_MESSAGE_DIV), isNull);
  });

  test('validation error in input field', () {
    fillUsername(INVALID_USERNAME);
    expectErrorMessage();
  });

  test('correct value in input field', () {
    fillUsername(VALID_USERNAME);
    expectNoErrorMessage();
  });

  test('pressing next button with invalid username', () {
    fillUsername(INVALID_USERNAME);
    pressNextButton();
    expectErrorMessage();
  });

  test('pressing next button with valid username', () {
    fillUsername(VALID_USERNAME);
    expectRendered(ERROR_MESSAGE_DIV);
    expectNotRendered(HAS_CHECKED_TOS_INPUT);

    pressNextButton();
    expectNotRendered(ERROR_MESSAGE_DIV);
    expectRendered(HAS_CHECKED_TOS_INPUT);
  });

  test('checking TOS', () {
    fillUsername(VALID_USERNAME);

    pressNextButton();
    expectNotRendered(SUCCESS_MESSAGE_DIV);

    checkTOSCheckbox();
    expectRendered(SUCCESS_MESSAGE_DIV);
  });
}
