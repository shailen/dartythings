//Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
//for details. All rights reserved. Use of this source code is governed by a
//BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import 'package:tracker/models.dart';

@CustomTag('task-element')
class TaskElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable Task task;
  @observable bool usingForm = false;

  toggleFormDisplay() {
    usingForm = !usingForm;
  }
}
