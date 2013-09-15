part of models;

final appModel = new Tracker.init();

class Tracker extends ObservableBase {
  @observable List<Task> tasks;
  @observable List<Task> currentTasks;
  @observable List<Task> pendingTasks;
  @observable List<Task> completedTasks;

  Tracker.init() {
    print('initializing tracker app');
  }

  String toString() {
    return 'tracker: currentTasks = $currentTasks';
  }
}

