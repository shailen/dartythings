import 'package:unittest/unittest.dart';
import 'package:unittest/mock.dart';
import 'package:person/model.dart';
import 'package:person/person_element.dart';
import 'dart:html';

class MockPerson extends Mock implements Person {}

void main() {
  MockPerson mp;
  PersonElement pe;

  setUp(() {
    mp = new MockPerson();
    pe = new PersonElement();
  });

  group('validateUsername', () {
    test('when usernameIsValid is false', () {
      mp.when(callsTo('get usernameIsValid')).thenReturn(false);
      pe.person = mp;
      pe.validateUsername(new Event('anything'));
      expect(pe.errorMessage, PersonElement.error_message);
    });

    test('when usernameIsValid is true', () {
      mp.when(callsTo('get usernameIsValid')).thenReturn(true);
      pe.person = mp;
      pe.validateUsername(new Event('anything'));
      expect(pe.errorMessage, isEmpty);
    });
  });

  group('showTOS', () {
    test('when usernameIsValid is false', () {
      mp.when(callsTo('get usernameIsValid')).thenReturn(false);
      pe.person = mp;
      pe.showTOSPanel();
      expect(pe.showTOS, isFalse);
    });

    test('when usernameIsValid is true', () {
      mp.when(callsTo('get usernameIsValid')).thenReturn(true);
      pe.person = mp;
      pe.showTOSPanel();;
      expect(pe.showTOS, isTrue);
    });
  });
}
