part of models;

class Tag extends Object with ObservableMixin {
  @observable String name;
  @observable String description;

  Tag(this.name, this.description);
}
