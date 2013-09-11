import 'package:polymer/polymer.dart';
import 'package:tracker/user.dart';

@CustomTag('user-list')
class TaskList extends PolymerElement with ObservableMixin {
  @observable List<User> users;
}