import 'dart:html';

import 'package:mdv/mdv.dart' as mdv;
import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

void main() {
  mdv.initialize();

  List<Task> tasks = toObservable([
      new Task('Write report'),
      new Task('CC copies to marketing',
          'Make sure report is no longer than a page.')]);

  query('#tracker-app-container').model = tasks;
}
