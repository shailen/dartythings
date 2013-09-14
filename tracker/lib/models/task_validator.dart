part of models;


class TaskValidator extends Object with ObservableMixin {
  @observable String title;
  @observable String description;

  // Use this to create a new task.
  TaskValidator() {
    this.title = '';
    this.description = '';
  }

  // Use this to edit an existing task.
  TaskValidator.fromTask(Task task) {
    this.title = task.title;
    this.description = task.description;
  }

  String toString() {
    return "TaskValidator: title = $title";
  }
}


class LengthValidation {
  String str;
  int minLength;
  int maxLength;
  LengthValidation(this.minLength, this.maxLength);

  bool validate() {

    ValidationResult result;
    if (this.minLength <= str.length && str.length < this.maxLength) {
      result = new ValidationResult(true, '');
    } else {
      result = new ValidationResult(false,
          'This field must be between $minLength and $maxLength characters');
    }
  }
}

class ValidationResult {
  bool result;
  String errorMessage;
  ValidationResult(this.result, this.errorMessage);
}