import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-element')
class TaskElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable Task task;
  @observable bool editingTask = false;

  toggleFormDisplay() {
    print('calling toggleFormDisplay');
    editingTask = !editingTask;
  }
}
