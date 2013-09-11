import 'dart:html';
import 'package:mdv/mdv.dart' as mdv;
import 'package:tracker/task.dart';
import 'package:tracker/user.dart';
import 'package:polymer/polymer.dart';

void main() {
  mdv.initialize();

  List<User> users = toObservable([new User('mem'), new User('rohan')]);
  List<Task> tasks = toObservable([
      new Task('Write report',
                "CC copies to marketing. Make sure report is no longer than a page.")]);

  query('#task-list-container').model = tasks;
  query('#user-list-container').model = users;
}
