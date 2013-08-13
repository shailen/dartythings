import 'dart:html';

// Map keys must be Symbols.
Map<Symbol, String> myMap = new Map();

main() {
  myMap[const Symbol('ca')] = 'California';
  myMap[const Symbol('ma')] = 'Massachusetts';
  myMap[const Symbol('pa')] = 'Pennsylvania';

  query('#states').model = myMap;
}
