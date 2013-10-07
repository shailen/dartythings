// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'package:polymer/polymer.dart';
import 'package:person/person_element.dart';
import 'dart:async';


main() {
  useHtmlConfiguration();
  // performMicrotaskCheckpoint();

//    <input class="form-control" placeholder="Enter username here"
//        on-keyup="validateUsername" value="{{person.username}}">

  test('initial state', () {
    final el = query('person-element');
    final root = el.shadowRoot;
    var input = root.query('input');
    expect(input.value, isEmpty);
    var errorMessageDiv = root.query('#error-message');
    expect(errorMessageDiv.text, isEmpty);
  });

  solo_test('error warning', () {
    final el = query('person-element');
    final root = el.shadowRoot;
    var input = root.query('input');
    var errorMessageDiv = root.query('#error-message');
    input.dispatchEvent(new KeyboardEvent('keyup'));
    expect(errorMessageDiv.text, PersonElement.error_message);
    input.value = 'asdf';
    input.dispatchEvent(new KeyboardEvent('keyup'));
    print(errorMessageDiv.text);

  });
}
