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

  @observable String title ;
  @observable String description;
  @observable int points;
  @observable String status;
  @observable DateTime createdAt;
  @observable DateTime updatedAt;
  @observable String searchClass = FOUND;

  Task(String title, {String description,
                      String category,
                      int points,
                      String status: Task.PENDING
                      }) {
    this.title = title;
    this.description = description;
    this.points = points;
    this.status = status;
  }
}
