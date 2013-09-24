import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';
import 'package:tracker/seed.dart' as seed;

import 'dart:async';

@CustomTag('tracker-app')
class TrackerApp extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;

  @observable ObservableList<Task> tasks = toObservable([]);

  @observable Tracker app;
  @observable Task newTask = new Task.unsaved();
  @observable String searchParam = '';
  @observable bool creatingNewTask = false;

  TrackerApp() {
    // OLD STUFF
    app = appModel;
    appModel.tasks = tasks;

    print(appModel.tasks.hashCode);
    print(tasks.hashCode);

    // Assign IDs to the seed data, so that task.saved == true.
    for (var i = 0; i < seed.data.length; i++) {
      seed.data[i].taskID = i;
      tasks.add(seed.data[i]);
      print(tasks[i]);
    }

    tasks.changes.listen((List<ChangeRecord> changes) {
      print('the main list changed');
      notifyProperty(this, const Symbol(Task.CURRENT));
      notifyProperty(this, const Symbol(Task.PENDING));
      notifyProperty(this, const Symbol(Task.COMPLETED));
    });
  }

  List<Task> get current => _filterTasks(Task.CURRENT).toList();
  List<Task> get pending => _filterTasks(Task.PENDING).toList();
  List<Task> get completed => _filterTasks(Task.COMPLETED).toList();

  void created() {
    super.created();


    print('*******************************');
    print(tasks);
    print(current);
    print(pending);
    print(completed);
    print('*******************************');

  }

  toggleNewTaskFormDisplay() {
    creatingNewTask = !creatingNewTask;
  }

  List<Task> _filterTasks(String status) {
    return tasks.where((task) => task.status == status).toList();
  }
}