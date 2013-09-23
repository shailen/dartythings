import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:survey/models.dart';

@CustomTag('question-element')
class QuestionElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable Question question = new Question();
  @observable bool editing = true;
  @observable String errorMessage = '';
  @observable List<String> answerOptions = ['text', 'radio', 'multi-checkbox'];
  @observable int answerSelectedIndex = 0;

  @observable List<Option> nonEmptyOptions = toObservable([]);


  inserted() {
    question.options = toObservable([new Option()]);
  }

  edit() {
    editing = true;
    errorMessage = '';
  }

  show(Event e, details, Node sender) {
    e.preventDefault();
    if (question.isValid) {
      editing = false;

      nonEmptyOptions = [];

      // TODO: good grief, just use a filter.
      for (var i = 0; i < question.options.length; i++) {
        if (question.options[i].text.isNotEmpty) {
          nonEmptyOptions.add(question.options[i]);
        }
      }
    } else {
      errorMessage = 'You forgot to add the question text';
    }
  }

  delete(Event e, details, Node sender) {
    if (window.confirm('Are you sure you want to delete this question?')) {
      appModel.questions.remove(question);
    }
  }

  addNewOption(Event e, detail, Node sender) {
    e.preventDefault();
    int unusedFields = question.options.where((option) => option.text.isEmpty).length;
    if (unusedFields == 1) {
      question.options.add(new Option());
    }
  }

  getRadioValue(Event e, detail, Node sender) {

  }
}