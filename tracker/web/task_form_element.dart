import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';
import 'dart:html';

@CustomTag('task-form-element')
class TaskFormElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable TaskForm taskForm;
  @observable String titleErrorMessage = '';
  @observable int maxTitleLength = Task.MAX_TITLE_LENGTH;
  @observable String descriptionErrorMessage = '';
  @observable int maxDescriptionLength = Task.MAX_DESCRIPTION_LENGTH;
  @observable List<String>taskStatusOptions = toObservable([
      Task.CURRENT, Task.PENDING, Task.COMPLETED]);
  @observable int statusSelectedIndex = 1;
  @observable String previousStatus = '';

  inserted() {
    super.inserted();
    if (taskForm.task != null) {
      statusSelectedIndex = taskStatusOptions.indexOf(taskForm.task.status);
      previousStatus = taskForm.task.status;
    }
  }

  setStatus(Event e) {
    print(statusSelectedIndex);
  }

  void toggleInUseStatus() {
    taskForm.inUse = !taskForm.inUse;
  }

  bool validateTitle() {
    int len = taskForm.title.length;
    bool valid = false;
    if (len == 0 && Task.TITLE_REQUIRED) {
      titleErrorMessage = 'Title is required';
    } else if (len > maxTitleLength) {
      titleErrorMessage = 'Title must be less than $maxTitleLength characters';
    } else {
      titleErrorMessage = '';
      valid = true;
    }
    return valid;
  }

  bool validateDescription() {
    int len = taskForm.description.length;
    bool valid = false;
    if (len >= maxDescriptionLength) {
      descriptionErrorMessage = 'Description must be less than '
          '$maxDescriptionLength characters';
    } else {
      descriptionErrorMessage = '';
      valid = true;
    }
    return valid;
  }

  createOrUpdateTask(Event event) {
    event.preventDefault();
    event.stopPropagation();

    if (!validateTitle() || !validateDescription()) return;

    if (taskForm.task != null) {
      updateTask();
    } else {
      createTask();
    }
    taskForm.inUse = false;
  }

  createTask() {
    DateTime now = new DateTime.now();
    Task task = new Task(
        taskForm.title,
        description: taskForm.description);
    task.createdAt = now;
    task.updatedAt = now;
    appModel.tasks.add(task);
    // For now, a new task is always marked pending.
    appModel.pendingTasks.add(task);
    taskForm.inUse = false;
    taskForm = new TaskForm();
  }

  updateTask() {
    DateTime now = new DateTime.now();
    taskForm.task.title = taskForm.title;
    taskForm.task.description = taskForm.description;
    taskForm.task.updatedAt = now;

    var previousStatus = taskForm.task.status;
    if (taskForm.task != null) {
      taskForm.task.status = taskStatusOptions[statusSelectedIndex];
      if (previousStatus == Task.CURRENT) {
        appModel.currentTasks.remove(taskForm.task);
      } else if (previousStatus == Task.PENDING) {
        appModel.pendingTasks.remove(taskForm.task);
      } else {
        appModel.completedTasks.remove(taskForm.task);
      }
    }
    if (taskForm.task.status == Task.CURRENT) {
      appModel.currentTasks.add(taskForm.task);
    } else if (taskForm.task.status == Task.PENDING) {
      appModel.pendingTasks.add(taskForm.task);
    } else {
      appModel.completedTasks.add(taskForm.task);
    }
  }

  // UGH. Is there not a better way?
  deleteTask(Event event) {
    event.preventDefault();
    Task t = this.taskForm.task;
    if (window.confirm('Really delete this?')) {
      if (t.status == Task.CURRENT) {
        appModel.currentTasks.remove(t);
      } else if (t.status == Task.PENDING) {
        appModel.pendingTasks.remove(t);
      } else {
        appModel.completedTasks.remove(t);
      }
    }
  }
}
