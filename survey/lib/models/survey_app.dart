part of models;

class SurveyApp extends ObservableBase {
  @observable String title = '';
  @observable String description = '';
  @observable List<Question> questions;

  SurveyApp();
}