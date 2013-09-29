part of models;

class Question extends ObservableBase {
  @observable String text;
  @observable String helpText;
  @observable List<String> options = [];
  @observable List<String> answers = [];

  Question([this.text='', this.helpText='']);

  bool get isValid => text.isNotEmpty;
}