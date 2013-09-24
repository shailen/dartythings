//Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
//for details. All rights reserved. Use of this source code is governed by a
//BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';
import 'package:tracker/seed.dart' as seed;

@CustomTag('tracker-app')
class TrackerApp extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable ObservableList<Task> tasks = toObservable([]);
  @observable Tracker app;
  @observable Task newTask = new Task.unsaved();
  @observable String searchParam = '';
  @observable bool creatingNewTask = false;

  List<Task> filteredOutTasks = [];

  TrackerApp() {
    app = appModel;
    appModel.tasks = tasks;

    for (var i = 0; i < seed.data.length; i++) {
      // Assign IDs to the seed data, so that task.saved == true.
      seed.data[i].taskID = i;
      tasks.add(seed.data[i]);
    }

    tasks.changes.listen((List<ChangeRecord> changes) {
      notifyProperty(this, const Symbol(Task.CURRENT));
      notifyProperty(this, const Symbol(Task.PENDING));
      notifyProperty(this, const Symbol(Task.COMPLETED));
    });
  }

  List<Task> get current =>   populateGetters(Task.CURRENT);
  List<Task> get pending =>   populateGetters(Task.PENDING);
  List<Task> get completed => populateGetters(Task.COMPLETED);

  toggleFormDisplay() {
    creatingNewTask = !creatingNewTask;
  }

  search() {
    tasks.addAll(filteredOutTasks);
    filteredOutTasks.clear();

    for (Task task in tasks) {
      if (!taskMatchesSearchParam(task)) {
        filteredOutTasks.add(task);
      }
    }

    for (Task task in filteredOutTasks) {
      tasks.remove(task);
    }
  }

  bool taskMatchesSearchParam(Task task) {
    var param = searchParam.toLowerCase();
    if (param.isEmpty) return true;
    return task.title.toLowerCase().contains(param) ||
        task.description.toLowerCase().contains(param);
  }

  populateGetters(String status) {
    return tasks.where((task) => task.status == status).toList();
  }
}