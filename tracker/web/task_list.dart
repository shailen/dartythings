import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-list')
class TaskList extends PolymerElement with ObservableMixin {
  @observable List<Task> tasks;
}

