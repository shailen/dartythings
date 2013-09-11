import 'dart:io';
import 'package:polymer/component_build.dart';
import 'package:polymer/deploy.dart' as deploy;

void main() {
  build(new Options().arguments, ['web/index.html']).then((_) => deploy.main());
}