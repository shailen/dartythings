library dgrep;

import 'dart:io';
import 'package:args/args.dart';

const USAGE = 'usage: dart dgrep.dart [-rnS] patterns file_or_directory';

ArgResults argResults;

void _printMatch(File file, List lines, int i) {
  StringBuffer sb = new StringBuffer();
  if (argResults['recursive']) sb.write('${file.path}:');
  if (argResults['line-number']) sb.write('${i + 1}:');
  sb.write(lines[i]);
  print(sb.toString());
}

_searchFile(File file, searchTerms) {
  file.readAsLines().then((lines) {
    for (var i = 0; i < lines.length; i++) {
      bool found = false;
      for (var j = 0; j < searchTerms.length && !found; j++) {
        if (lines[i].contains(searchTerms[j])) {
          _printMatch(file, lines, i);
          found = true;
        }
      }
    }
  }).catchError(print);
}

void main() {
  final parser = new ArgParser()
      ..addFlag('recursive', negatable: false, abbr: 'r')
      ..addFlag('line-number', negatable: false, abbr: 'n')
      ..addFlag('followLinks', negatable: false, abbr: 'S');

  argResults = parser.parse(new Options().arguments);

  if (argResults.rest.length < 2) {
    print(USAGE);
    exit(1);
  }

  final searchPath = argResults.rest.last;
  final searchTerms = argResults.rest.sublist(0, argResults.rest.length - 1);

  FileSystemEntity.isDirectory(searchPath).then((isDir) {
    if (isDir) {
      final startingDir = new Directory(searchPath);
      startingDir.list(recursive:   argResults['recursive'],
                       followLinks: argResults['followLinks']).listen((entity) {
        if (entity is File) {
          _searchFile(entity, searchTerms);
        }
      });
    } else {
      _searchFile(new File(searchPath), searchTerms);
    }
  });
}