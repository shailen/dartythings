import 'package:polymer/polymer.dart';

@CustomTag('click-counter')
class ClickCounter extends PolymerElement with ObservableMixin {
  @observable int count = 0;

  void increment() {
    count++;
  }

  ClickCounter() {
    bindProperty(this, const Symbol('count'),
        () => notifyProperty(this, const Symbol('divByThree')));
  }

  bool get divByThree => count % 3 == 0;

  void created() {
    super.created();
    var root = getShadowRoot("click-counter");
    var item = root.query('#click-display');
    bindCssClass(item, 'blue', this, 'divByThree');
  }
}

