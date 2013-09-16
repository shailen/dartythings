import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';
import 'package:tracker/seed.dart' as seed;

@CustomTag('tracker-app')
class TrackerApp extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable Tracker app;
  @observable TaskForm taskForm;

  // TODO: move this to taskForm?
  toggleNewTaskFormDisplay() {
    taskForm.inUse = !taskForm.inUse;
  }

  void created() {
    super.created();
    app = appModel;
    appModel.tasks = toObservable(seed.data);
  }

  inserted() {
    super.inserted();
    app.currentTasks = toObservable(_filterTasks(Task.CURRENT));
    app.pendingTasks = toObservable(_filterTasks(Task.PENDING));
    app.completedTasks = toObservable(_filterTasks(Task.COMPLETED));
    taskForm = new TaskForm();
  }

  List<Task> _filterTasks(String label) {
    return app.tasks.where((task) => task.status == label).toList();
  }
}
