import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-element')
class TaskElement extends PolymerElement with ObservableMixin {
  @observable Task task;
  @observable TaskForm taskForm;

  void toggleDisplay() {
    taskForm.inUse = !taskForm.inUse;
  }

  inserted() {
    super.inserted();
    taskForm = new TaskForm.fromTask(task);
  }
}
