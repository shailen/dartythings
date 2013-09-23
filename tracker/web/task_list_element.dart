import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-list-element')
class TaskListElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable List<Task> tasks;

  deleteTask(Event e, detail, Node sender) {
    e.preventDefault();
    if (window.confirm('Are you sure you want to delete this?')) {
      sender.remove();
    }
  }
}
