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

  @observable List<String> opts;
  @observable List<String> temp = toObservable([]);

  @observable Question question = new Question();
  @observable bool editing = true;
  @observable String errorMessage = '';
  @observable List<String> widgetOptions = [TEXT, ONE_FROM_MANY,
                                            MANY_FROM_MANY];
  @observable int widgetSelectedIndex = 0;
  @observable String textAnswerValue = '';

  // TODO: hack, remove later.
  @observable List attrs;

  inserted() {
    opts = toObservable(['']);
  }

  edit() {
    editing = true;
    errorMessage = '';
  }

  adjustOpts(Event e, var detail, Element sender) {
    e.preventDefault();
      opts.add('');
  }

  void getInputValues() {
    var root = getShadowRoot('question-element');
    var ul = root.query('#input-container');
    var inputs = ul.queryAll('input');

    inputs.forEach((input) {
      var val = input.value.trim();
      if (val.isNotEmpty) {
        temp.add(val);
      }
    });
  }

  show(Event e, var detail, Node sender) {
    e.preventDefault();
    getInputValues();

    if (question.isValid) {
      if (widgetSelectedIndex != 0 && temp.length == 0) {
        errorMessage = "You didn't add any options";
        return;
      }
    } else {
      errorMessage = 'You forgot to add the question text';
      return;
    }
    attrs = toObservable([temp, true]);
    editing = false;
  }

  delete(Event e, details, Node sender) {
    if (window.confirm('Are you sure you want to delete this question?')) {
      appModel.questions.remove(question);
    }
  }


  getSelection(Event e, detail, Node sender) {
    e.preventDefault();
    print(detail);
  }
}