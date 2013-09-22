import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:survey/models.dart';

@CustomTag('survey-element')
class SurveyElement extends PolymerElement with ObservableMixin {
  bool get applyAuthorStyles => true;
  @observable SurveyApp app = new SurveyApp();

  created() {
    super.created();
    app.questions = toObservable([]);
  }

  inserted() {
    super.inserted();
    app.questions.add(new Question("Who is buried in Grant's tomb?",
        'This might be a trick question.' ));
  }

  addQuestion(Event e, detail, Node sender) {
    e.preventDefault();
    app.questions.add(new Question());
  }

  addNewQuestion() {
    app.questions.add(new Question());
  }
}

