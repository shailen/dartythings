part of models;

class Question extends ObservableBase {
  @observable int id;
  @observable String text;
  @observable String helpText;
  List<String> options;

  Question([this.text='', this.helpText='']) {
    Random random = new Random();
    id = random.nextInt(1000 * 1000);
  }

  bool get isValid => text.isNotEmpty;
}