import 'package:mdv/mdv.dart' as mdv;
import 'package:tracker/models.dart';

List<Task> tasks;

void main() {
  mdv.initialize();

  var str = 'Dart     is  \t  fun';
  var regExp = new RegExp(r'\s+');
  print(str.replaceAll(regExp, ' '));
}
