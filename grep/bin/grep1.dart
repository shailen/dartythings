import 'dart:io';

void main() {
  List<String> results = [];
  var filename = '/Users/shailentuli/workspace/coreutils/src/tee.c';
  var fh = new File(filename);
  var text = 'error';
  var regExp = new RegExp(text);
  fh.readAsLines().then((lines) {
    for (var i = 0; i < lines.length; i++) {
      if (regExp.hasMatch(lines[i])) {
        results.add(lines[i]);
      }
    }
  }).then((_) {
    for (var result in results) {
      print(result);
    }
  });
}