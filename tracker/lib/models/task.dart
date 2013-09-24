//Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
//for details. All rights reserved. Use of this source code is governed by a
//BSD-style license that can be found in the LICENSE file.


part of models;

class Task extends Object with ObservableMixin {
  static bool TITLE_REQUIRED = true;
  static const MAX_TITLE_LENGTH = 40;
  static const MAX_DESCRIPTION_LENGTH = 200;
  static const CURRENT = 'current';
  static const PENDING = 'pending';
  static const COMPLETED = 'completed';
  static const FOUND = 'foundInSearch';
  static const NOT_FOUND = 'notFoundInSearch';

  @observable int taskID;
  @observable String title = '';
  @observable String description = '';
  @observable String status = PENDING;
  @observable DateTime createdAt;
  @observable DateTime updatedAt;

  Task.unsaved();

  Task(this.title, this.description, this.status);

  bool get isValid {
    var minTitleLength = TITLE_REQUIRED ? 1 : 0;
    return (title.length > minTitleLength &&
    title.length < MAX_DESCRIPTION_LENGTH &&
    description.length < MAX_DESCRIPTION_LENGTH);
  }

  bool get saved => taskID != null;
}
