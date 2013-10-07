import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

import "package:person/model.dart";

String _stringOfLength(int len) {
  return new List.filled(len, 'x').join('');
}

void main() {
  useHtmlConfiguration();
  test('person', () {
    var person = new Person();
    expect(person.username, isEmpty);
    expect(person.hasCheckedTOS, isFalse);
  });

  test('usernameIsValid', () {
    var person = new Person();
    expect(person.usernameIsValid, isFalse);
  });

  test('min length', () {
    var person = new Person();
    person.username = _stringOfLength(Person.MIN_USERNAME_LENGTH - 1);
    expect(person.usernameIsValid, isFalse);
    person.username = _stringOfLength(Person.MIN_USERNAME_LENGTH);
    expect(person.usernameIsValid, isTrue);
  });

  test('max length', () {
    var person = new Person();
    person.username = _stringOfLength(Person.MAX_USERNAME_LENGTH);
    expect(person.usernameIsValid, isTrue);
    person.username = _stringOfLength(Person.MAX_USERNAME_LENGTH + 1);
    expect(person.usernameIsValid, isFalse);
  });
}