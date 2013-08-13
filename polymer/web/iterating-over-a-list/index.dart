import 'dart:html';

List<String> cities = ['London', 'Tokyo', 'Bangalore'];

void main() {
  query('#_template').model = cities;

}