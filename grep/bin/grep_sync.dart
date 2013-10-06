import 'dart:io';

var results = [];

grep(File file, regExp) {
  var lines = file.readAsLinesSync();
  for (var i = 0; i < lines.length; i++) {
    if (regExp.hasMatch(lines[i])) {
      results.add('${file.path}:${i + 1}:${lines[i]}');
    }
  }
}

void main() {
  var path = 'coreutils/src/cat.c';
  var start;
  var searchText = '';
  List files = [];
  var regExp = new RegExp(searchText);
  if (FileSystemEntity.isDirectorySync(path)) {
    start = new Directory(path);
    files = start.listSync(recursive: true).where((x) => x is File).toList();
  } else {
    files.add(new File(path));
  }

  for (var i = 0; i < files.length; i++) {
    grep(files[i], regExp);
  }

  for (var result in results) {
    print(result);
  }
}