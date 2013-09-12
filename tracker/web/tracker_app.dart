import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('tracker-app')
class TrackerApp extends PolymerElement with ObservableMixin {
  @observable List<Story> stories;
}

