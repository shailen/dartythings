import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-item')
class TaskItem extends PolymerElement with ObservableMixin {
  @observable Task task;
  @observable bool showFull = false;

  void toggleDisplay() {
    showFull = !showFull;
  }
}
