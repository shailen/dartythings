import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';
import 'package:tracker/seed.dart' as seed;

@CustomTag('tracker-app')
class TrackerApp extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable Tracker app;
  @observable Task task;
  @observable String searchParam = '';
  @observable bool creatingNewTask = false;

  void created() {
    super.created();
    app = appModel;
    appModel.tasks = toObservable(seed.data);
    for (var i = 0; i < appModel.tasks.length; i++) {
      appModel.tasks[i].taskID = i;
    }

    app.currentTasks = toObservable(_filterTasks(Task.CURRENT));
    app.pendingTasks = toObservable(_filterTasks(Task.PENDING));
    app.completedTasks = toObservable(_filterTasks(Task.COMPLETED));
  }

  toggleNewTaskFormDisplay() {
    creatingNewTask = !creatingNewTask;
  }

  search() {
//    var taskLists = [app.currentTasks, app.pendingTasks, app.completedTasks];
//    taskLists.forEach((taskList) {
//      for (Task task in taskList) {
//        if (searchParam.length < 4) {
//          task.searchClass = '';
//        } else {
//          if (task.title.contains(searchParam)) {
//            task.searchClass = Task.FOUND;
//          } else {
//            task.searchClass = Task.NOT_FOUND;
//          }
//        }
//      }
//    });
  }

  List<Task> _filterTasks(String label) {
    return app.tasks.where((task) => task.status == label).toList();
  }
}