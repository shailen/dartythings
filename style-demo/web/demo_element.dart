library clickcounter;

import 'package:polymer/polymer.dart';

@CustomTag('demo-element')
class DemoElement extends PolymerElement {
  bool applyAuthorStyles = false;

  DemoElement.created() : super.created() {}
}

