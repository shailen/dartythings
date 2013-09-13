import 'dart:html';

import 'package:mdv/mdv.dart' as mdv;
import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';
import 'package:tracker/seed.dart' as seed;

List<Task> tasks;

void main() {
  mdv.initialize();
  tasks = toObservable(seed.data);
  TemplateElement template = query('#tracker-app-container');
  template.model = tasks;

}
