library task;

import 'package:polymer/polymer.dart';

class Task extends Object with ObservableMixin {
  @observable String title;
  @observable String description;

  Task(this.title, this.description);
}