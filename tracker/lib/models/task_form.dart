part of models;

class TaskForm extends Object with ObservableMixin {
  @observable Task task;
  @observable bool inUse = false;

  // Task fields that are user editable.
  @observable String title = '';
  @observable String description = '';

  // Use when creating a new Task.
  TaskForm() {}

  // Use when editing existing Task.
  TaskForm.fromTask(Task task) {
    this.task = task;
    this.title = task.title;
    this.description = task.description;
  }

  String toString() {
    return "TaskForm: hashCode = ${this.hashCode}";
  }
}