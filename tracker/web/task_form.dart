import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';
import 'dart:html';

@CustomTag('task-form')
class TaskForm extends PolymerElement with ObservableMixin {
  @observable TaskValidator taskValidator;
  @observable String formErrorMessage = '';

  @observable String titleMessage = '';
  @observable bool titleError = false;
  @observable int maxTitleLength = 30;

  @observable String descriptionMessage = '';
  @observable bool descriptionError = false;
  @observable int maxDescriptionLength = 250;


  validateTitle() {
    var len = taskValidator.title.length;
    if (len == 0 || len > maxTitleLength) {
      titleError = true;
      titleMessage = len == 0 ? "Title can't be empty" :
        "Title must be less than $maxTitleLength characters.";
    } else {
      titleError = false;
    }
  }

  validateDescription() {
    var len = taskValidator.description.length;
    if (len > maxDescriptionLength) {
      descriptionError = true;
      descriptionMessage = "Description must be less than $maxDescriptionLength characters.";
    } else {
      descriptionError = false;
    }
  }
}

class NewTaskForm extends TaskForm with ObservableMixin {
  createTask(Event event) {
    event.preventDefault();
    if (!titleError && ! descriptionError) {
      DateTime now = new DateTime.now();
      Task task = new Task(
          taskValidator.title,
          description: taskValidator.description);
      task.createdAt = now;
      task.updatedAt = now;

      appModel.tasks.add(task);
      // For now, a new task is always marked pending.
      appModel.pendingTasks.add(task);
      taskValidator = new TaskValidator();

    } else {
      formErrorMessage = "Please fix the errors and then resubmit";
    }
  }
}

class EditTaskForm extends TaskForm with ObservableMixin {
  @observable Task task;

  updateTask(Event event) {
    event.preventDefault();
    if (!titleError && ! descriptionError) {
      task.title = taskValidator.title;
      task.description = taskValidator.description;
      task.updatedAt = new DateTime.now();
      taskValidator = new TaskValidator.fromTask(task);
    } else {
      formErrorMessage = "Please fix the errors and then resubmit";
    }
  }
}




