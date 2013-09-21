import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';
import 'dart:html';
import 'dart:math';

@CustomTag('task-form-element')
class TaskFormElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable Task task;
  @observable String titleErrorMessage = '';
  @observable int maxTitleLength = Task.MAX_TITLE_LENGTH;
  @observable String descriptionErrorMessage = '';
  @observable int maxDescriptionLength = Task.MAX_DESCRIPTION_LENGTH;
  @observable List<String>taskStatusOptions = toObservable([
      Task.CURRENT, Task.PENDING, Task.COMPLETED]);
  @observable int statusSelectedIndex = 1;
  @observable String previousStatus = '';
  @observable String submitLabel = '';
  @observable bool display = true;

  created() {
    super.created();
  }

  inserted() {
    super.inserted();
    submitLabel = task.saved ? 'Update' : 'Create';
    print(submitLabel);
    print(task.taskID);

    if (!task.saved) {
      statusSelectedIndex = taskStatusOptions.indexOf(task.status);
      previousStatus = task.status;
    }
  }

  bool validateTitle() {
    int len = task.title.length;
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
    int len = task.description.length;
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

  createOrUpdateTask(Event event, detail, sender) {
    event.preventDefault();
    event.stopPropagation();
    print(detail.runtimeType);
    print(sender.runtimeType);
    print(task);

    if (!task.isValid) return;


    if (task.saved) {
      updateTask();
    } else {
      createTask();
    }

    // TODO: refactor this code.
    if (task.status == Task.CURRENT) {
      appModel.currentTasks.add(task);
    } else if (task.status == Task.PENDING) {
      appModel.pendingTasks.add(task);
    } else {
      appModel.completedTasks.add(task);
    }
    display = false;
    dispatchEvent(new CustomEvent('close-form'));
  }

  createTask() {
    print('inside createTask');
    DateTime now = new DateTime.now();
    var random = new Random();
    task.taskID = random.nextInt(1000 * 1000);
    print(task.taskID);

    task.createdAt = now;
    task.updatedAt = now;
    appModel.tasks.add(task);

  }

  updateTask() {
    DateTime now = new DateTime.now();
    task.updatedAt = now;
    var previousStatus = task.status;
    task.status = taskStatusOptions[statusSelectedIndex];
    if (previousStatus == Task.CURRENT) {
      appModel.currentTasks.remove(task);
    } else if (previousStatus == Task.PENDING) {
      appModel.pendingTasks.remove(task);
    } else {
      appModel.completedTasks.remove(task);
    }
  }

  deleteTask(Event event) {
    event.preventDefault();
    if (window.confirm('Really delete this?')) {
      if (task.status == Task.CURRENT) {
        appModel.currentTasks.remove(task);
      } else if (task.status == Task.PENDING) {
        appModel.pendingTasks.remove(task);
      } else {
        appModel.completedTasks.remove(task);
      }
    }
  }
}
