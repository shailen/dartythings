part of models;

final appModel = new SurveyApp();

class SurveyApp extends ObservableBase {
  @observable String title = '';
  @observable String description = '';
  @observable List<Question> questions;

  SurveyApp();
}