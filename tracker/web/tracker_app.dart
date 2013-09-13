import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

import 'dart:html';

@CustomTag('tracker-app')
class TrackerApp extends PolymerElement with ObservableMixin {
  @observable List<Task> tasks;
  @observable List<Task> currentTasks;
  @observable List<Task> pendingTasks;
  @observable List<Task> completedTasks;

  inserted() {
    super.inserted();
    currentTasks = toObservable(_filterTasks('current'));
    pendingTasks = toObservable(_filterTasks('pending'));
    completedTasks = toObservable(_filterTasks('completed'));
    var trackerApp = getShadowRoot('tracker-app');
    TemplateElement newTaskFormContainer = trackerApp.query('#new-task-form-container');
    TaskValidator validator = new TaskValidator.fromTask(tasks.first);
    newTaskFormContainer.model = validator;
    print('Inside tracker_app.dart#inserted, validator = $validator');
  }

  List<Task> _filterTasks(String label) {
    return tasks.where((task) => task.status == label).toList();
  }

  // TODO: change all this. *Always* go through the validator.
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
    tasks.add(task);
    pendingTasks = _filterTasks('pending');
    title.value = '';
    description.value = '';
  }
}
