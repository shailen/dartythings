import 'dart:io';

// We add support for catching FileExceptions

void main() {
  List<String> results = [];
  var filename = '/Users/shailentuli/workspace/coreutils/src/tee.xx';
  var fh = new File(filename);
  var text = 'error';
  var regExp = new RegExp(text);
  fh.readAsLines().then((lines) {
    for (var i = 0; i < lines.length; i++) {
      if (regExp.hasMatch(lines[i])) {
        results.add(lines[i]);
      }
    }
  }).catchError((FileException fe) {
    print(fe);
    return;
  }).then((_) {
    for (var result in results) {
      print(result);
    }
  });
}