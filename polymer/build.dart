import 'dart:io';
import 'package:polymer/component_build.dart';

main() {
  build(new Options().arguments, ['web/counter/index.html',
                                  'web/counter2/index.html']);
}
