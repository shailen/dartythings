part of models;

class Question extends ObservableBase {
  @observable String text;
  @observable String helpText;
  @observable bool required = false;
  Question([this.text='', this.helpText='']);

  bool get isValid => text.isNotEmpty;
}