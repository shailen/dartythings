import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:survey/models.dart';

// TODO: they can't pick a selection and have everything be empty
// TODO: deal with a case of a single option

@CustomTag('question-element')
class QuestionElement extends PolymerElement with ObservableMixin {
  static const TEXT = 'Use a text field';
  static const ONE_FROM_MANY = 'Select one from many options';
  static const MANY_FROM_MANY = 'Select many from many options';

  bool get applyAuthorStyles => true;

  @observable Question question = new Question();
  @observable bool editing = true;
  @observable String errorMessage = '';
  @observable List<String> widgetOptions = [TEXT, ONE_FROM_MANY,
                                            MANY_FROM_MANY];
  @observable int widgetSelectedIndex = 0;

  @observable List<Option> nonEmptyOptions = toObservable([]);
  @observable String textAnswerValue = '';
//  @observable String radioValue = '';

  // TODO: hack, remove later.
  @observable List attrs;

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

      for (var i = 0; i < question.options.length; i++) {
        if (question.options[i].text.isNotEmpty) {
          nonEmptyOptions.add(question.options[i]);
        }
      }

      if (widgetOptions[widgetSelectedIndex] != 0) {
        if (nonEmptyOptions.length == 0) {
          errorMessage = "You didn't add any options";
          editing = true;
        }
      }
    } else {
      errorMessage = 'You forgot to add the question text';
    }
    attrs = toObservable([nonEmptyOptions, true]);
  }

  delete(Event e, details, Node sender) {
    if (window.confirm('Are you sure you want to delete this question?')) {
      appModel.questions.remove(question);
    }
  }

  addNewOption(Event e, detail, Node sender) {
    e.preventDefault();
    int unusedFields = question.options.where((option) {
      return option.text.isEmpty;
    }).length;

    if (unusedFields == 1) {
      question.options.add(new Option());
    }
  }

  getSelection(Event e, detail, Node sender) {
    e.preventDefault();
    print(detail);
  }
}