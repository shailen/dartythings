import 'dart:async';
import 'dart:html';
import 'dart:js';

void main() {
  DivElement statusDiv = querySelector('#trip-status');

  // Instantiating a constructor function.
  var trip = new JsObject(context['Trip']);

  // Assigning value to a field.
  trip['destination'] = 'Aruba';

  // Calling a method with an argument.
  var result = trip.callMethod('start', [10]);
  statusDiv.text = result;

  // Firing a callback.
  // The end() method takes one arg: a function that takes an arg
  new Timer(new Duration(seconds: 2), () {
    trip.callMethod('end', [(msg) {
      statusDiv.text = 'All rested. $msg';
    }]);
  });
}
