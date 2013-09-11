library user;

import 'package:polymer/polymer.dart';

class User extends Object with ObservableMixin {
  @observable String username;
  User(this.username);
}