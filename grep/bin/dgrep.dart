import 'dart:io';
import 'package:args/args.dart';

void printResult(File file, List lines, int i) {
  StringBuffer sb = new StringBuffer();
  if (argResults['recursive']) sb.write('${file.path}:');
  if (argResults['line-number']) sb.write('${i + 1}:');
  sb.write(lines[i]);
  print(sb.toString());
}

grep(File file, regExps) {
  file.readAsLines().then((lines) {
    for (var i = 0; i < lines.length; i++) {
      bool found = false;
      for (var j = 0; j < regExps.length && !found; j++) {
        if (regExps[j].hasMatch(lines[i])) {
          printResult(file, lines, i);
          found = true;
        }
      }
    }
  }).catchError((FileException exception) {
    print('Error:');
    print(exception);
  });
}

void showUsage() {
  print('''
usage: dart dgrep.dart [-rnS] patterns file_or_directory
''');
}

ArgResults argResults;
List<RegExp> grepRegExps = [];

void main() {
  Directory startingDir;

  var parser = new ArgParser();
  parser..addFlag('recursive', negatable: false, abbr: 'r')
        ..addFlag('line-number', negatable: false, abbr: 'n')
        ..addFlag('followLinks', negatable: false, abbr: 'S');

  argResults = parser.parse(new Options().arguments);
  if (argResults.rest.length < 2) {
    showUsage();
    exit(1);
  }

  var searchPath = argResults.rest.last;
  var searchTerms = argResults.rest.sublist(0, argResults.rest.length - 1);
  searchTerms.forEach((searchTerm) {
    grepRegExps.add(new RegExp(searchTerm));
  });

  FileSystemEntity.isDirectory(searchPath).then((isDir) {
    if (isDir) {
      startingDir = new Directory(searchPath);
      startingDir.list(recursive:   argResults['recursive'],
                       followLinks: argResults['followLinks']).listen((entity) {
        if (entity is File) {
          grep(entity, grepRegExps);
        }
      });
    } else {
      grep(new File(searchPath), grepRegExps);
    }
  });
}