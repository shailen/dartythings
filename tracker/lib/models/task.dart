part of models;

class Task extends Object with ObservableMixin {
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
