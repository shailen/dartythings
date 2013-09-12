import 'dart:html';

import 'package:mdv/mdv.dart' as mdv;
import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

void main() {
  mdv.initialize();

  List<Story> stories = toObservable([
      new Story('Write report'),
      new Story('CC copies to marketing',
          'Make sure report is no longer than a page.')]);

  query('#tracker-app-container').model = stories;
}
