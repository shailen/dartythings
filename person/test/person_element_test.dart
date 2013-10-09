import 'package:unittest/unittest.dart';
import 'package:unittest/mock.dart';
import 'package:unittest/html_config.dart';
import 'package:person/model.dart';
import 'package:person/person_element.dart';
import 'dart:html';

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
      expect(personElement.errorMessage, PersonElement.error_message);
    });

    test('when usernameIsValid is true', () {
      mockPerson.when(callsTo('get usernameIsValid')).thenReturn(true);
      personElement.person = mockPerson;
      personElement.validateUsername(new Event('anything'));
      expect(personElement.errorMessage, isEmpty);
    });
  });
}