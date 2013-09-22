import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:survey/models.dart';

@CustomTag('question-element')
class QuestionElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable Question question = new Question();
  @observable bool editing = true;
  @observable String errorMessage = '';

  inEditMode() {
    editing = true;
  }

  inReadMode(Event e, details, Node sender) {
    e.preventDefault();
    if (question.isValid) {
      editing = false;
    } else {
      errorMessage = 'You forgot to add the question text';
    }
  }
}