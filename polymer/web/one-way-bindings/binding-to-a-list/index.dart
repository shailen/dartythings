import 'dart:html';

List<String> fruits = ['apple', 'papaya', 'peach'];

main() {
  // Get a DOM element and assign it a model.
  query('#greeting').model = fruits;
}