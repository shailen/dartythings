import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-form')
class TaskForm extends PolymerElement with ObservableMixin {
  @observable TaskValidator taskValidator;

  validateTitle() {
    print('validating');
  }

  String toString() {
    return 'TaskForm Polymer element: taskValidator = $taskValidator';
  }
}