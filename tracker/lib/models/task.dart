part of models;

class Task extends Object with ObservableMixin {
  static bool TITLE_REQUIRED = true;
  static const MAX_TITLE_LENGTH = 30;
  static const MAX_DESCRIPTION_LENGTH = 250;

  @observable String title ;
  @observable String description;
  @observable int points;
  @observable String status;
  @observable DateTime createdAt;
  @observable DateTime updatedAt;

  Task(String title, {String description,
                      String category,
                      int points,
                      String status: 'pending'
                      }) {
    this.title = title;
    this.description = description;
    this.points = points;
    this.status = status;
  }
}
