part of models;

class Story extends Object with ObservableMixin {
  @observable String title ;
  @observable String description;
  @observable DateTime created_at;
  @observable DateTime updated_at;
  @observable String type;
  @observable int points;
  @observable String status;
  @observable User owned_by;
  @observable User requested_by;
  @observable List<Tag> tags;

  Story(this.title, [this.description]);
}
