import 'dart:html';

List<List<String>> names = [['A', 'B', 'C'],
                              ['P', 'Q', 'R'],
                              ['X', 'Y', 'Z']];

void main() {
  query("#_template").model = names;

}