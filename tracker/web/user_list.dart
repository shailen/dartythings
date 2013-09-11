import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('user-list')
class TaskList extends PolymerElement with ObservableMixin {
  @observable List<User> users;
}