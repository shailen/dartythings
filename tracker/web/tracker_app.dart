import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';
import 'package:tracker/seed.dart' as seed;
import 'dart:html';

@CustomTag('tracker-app')
class TrackerApp extends PolymerElement with ObservableMixin {
  @observable Tracker app;
  @observable bool showNewTaskForm = false;
  @observable TaskValidator newTaskValidator = new TaskValidator();

  toggleNewTaskFormDisplay() {
    showNewTaskForm = !showNewTaskForm;
  }

  void created() {
    super.created();
    app = appModel;
    appModel.tasks = toObservable(seed.data);
  }

  inserted() {
    super.inserted();
    app.currentTasks = toObservable(_filterTasks('current'));
    app.pendingTasks = toObservable(_filterTasks('pending'));
    app.completedTasks = toObservable(_filterTasks('completed'));
  }

  List<Task> _filterTasks(String label) {
    return app.tasks.where((task) => task.status == label).toList();
  }


  // TODO: change all this. *Always* go through the validator.
  // TODO: don't do this from here. Add from the element itself.
  void addTask(Event e) {
    e.preventDefault();
    var trackerApp = getShadowRoot('tracker-app');
    var form = trackerApp.query('#new-app-form');

    var title = form.query('#title-field');
    var description = form.query('#description-field');

    // TODO: need proper validation.
    if (title.value.isEmpty) return;
    Task task = new Task(title.value.trim(),
        description: description.value.trim());
    app.tasks.add(task);
    app.pendingTasks = _filterTasks('pending');
    title.value = '';
    description.value = '';
  }
}
