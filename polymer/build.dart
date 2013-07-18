import 'dart:io';
import 'package:polymer/component_build.dart';

main() {
  build(new Options().arguments, ['web/counter_with_component/index.html',
                                  'web/counter_without_component/index.html']);
}
