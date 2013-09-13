part of models;

// All Task fields that are user-modifiable go in here.
// All validation goes in here.
class TaskValidator extends Object with ObservableMixin {
  @observable String title;

  // Use this to create a new task.
  TaskValidator() {
    this.title = '';
  }

  // Use this to edit an existing task.
  TaskValidator.fromTask(Task task) {
    this.title = task.title;
    print('this.title = ${this.title}');
  }

  String toString() => "TaskValidator: title = $title";
}
