import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('tag-list')
class TagList extends PolymerElement with ObservableMixin {
  @observable List<Tag> tags;
}
