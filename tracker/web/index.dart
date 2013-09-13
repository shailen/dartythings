import 'dart:html';

import 'package:mdv/mdv.dart' as mdv;
import 'package:polymer/polymer.dart';
import 'package:polymer_expressions/polymer_expressions.dart';
import 'package:tracker/models.dart';
import 'package:tracker/seed.dart' as seed;

List<Task> tasks;

void main() {
  mdv.initialize();
  tasks = toObservable(seed.data);
  TemplateElement template = query('#tracker-app-container');
  template.bindingDelegate = new PolymerExpressions(globals: {
    'pending': (List<Task> tasks) {
      return tasks.where((task) => task.status == 'pending');
    }
  });

  template.model = tasks;

}
