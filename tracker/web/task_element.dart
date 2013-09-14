import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-element')
class TaskElement extends PolymerElement with ObservableMixin {
  @observable Task task;
  @observable bool showFull = false;
  @observable TaskValidator taskValidator;

  void toggleDisplay() {
    showFull = !showFull;
  }

  inserted() {
    super.inserted();
    taskValidator = new TaskValidator.fromTask(task);
  }
}
