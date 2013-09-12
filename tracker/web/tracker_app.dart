import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('tracker-app')
class TrackerApp extends PolymerElement with ObservableMixin {
  @observable List<Task> tasks;
  @observable List<Task> currentTasks;
  @observable List<Task> pendingTasks;
  @observable List<Task> completedTasks;

  inserted() {
    currentTasks = tasks.where((task) => task.status == 'current').toList();
    pendingTasks = tasks.where((task) => task.status == 'pending').toList();
    completedTasks = tasks.where((task) => task.status == 'completed').toList();
  }
}
