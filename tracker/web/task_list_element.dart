import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-list-element')
class TaskListElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable List<Task> tasks;
}
