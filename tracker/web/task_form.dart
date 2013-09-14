import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-form')
class TaskForm extends PolymerElement with ObservableMixin {
  @observable TaskValidator taskValidator;

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



