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

  created() {
    super.created();
  }

  inserted() {
    super.inserted();
    submitLabel = task.saved ? 'Update' : 'Create';
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

    dispatchEvent(new CustomEvent('close-form'));
  }

  createTask() {
    print('inside createTask()');
    DateTime now = new DateTime.now();
    var random = new Random();
    print(task.status);
    task.taskID = random.nextInt(1000 * 1000);
    task.createdAt = now;
    task.updatedAt = now;
    appModel.tasks.add(task);
  }

  updateTask() {
    DateTime now = new DateTime.now();
    task.updatedAt = now;
    var previousStatus = task.status;
    task.status = taskStatusOptions[statusSelectedIndex];
    if (previousStatus != task.status) {
      if (previousStatus == Task.CURRENT) {
        appModel.currentTasks.remove(task);
      } else if (previousStatus == Task.PENDING) {
        appModel.pendingTasks.remove(task);
      } else {
        appModel.completedTasks.remove(task);
      }
    }
  }

  // TODO: use custom event to remove from sublist, and then remove from tasks.
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
