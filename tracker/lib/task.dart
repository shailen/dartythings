library task;

import 'package:polymer/polymer.dart';
import 'package:tracker/user.dart';

class Task extends Object with ObservableMixin {
  @observable String title;
  @observable String description;
  @observable List<User> users;

  Task(this.title, this.description, [this.users]);
}