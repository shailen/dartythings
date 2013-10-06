import 'dart:io';

var results = [];

grep(File file, regExp) {
  file.readAsLines().then((lines) {
    for (var i = 0; i < lines.length; i++) {
      if (regExp.hasMatch(lines[i])) {
        print('${file.path}:${i + 1}:${lines[i]}');
      }
    }
  }).catchError((FileException exception) {
    print('There was an error');
    print(exception);
  });
}

void main() {
  var path = 'coreutils/src/cat.c';
  var start;
  var searchText = 'error';
  List files = [];
  var regExp = new RegExp(searchText);
  FileSystemEntity.isDirectory(path).then((isDir) {
    if (isDir) {
      files.add('dir');
      start = new Directory(path);
      start.list(recursive: true).listen((entity) {
        if (entity is File) {
          grep(entity, regExp);
        }
      });
    } else {
      grep(new File(path), regExp);
    }
  });
}