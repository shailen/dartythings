part of models;

class User extends Object with ObservableMixin {
  @observable String username;
  User(this.username);
}