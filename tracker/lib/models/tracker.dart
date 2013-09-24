part of models;

final appModel = new Tracker();

class Tracker extends ObservableBase {
  @observable List<Task> tasks;
  @observable String successNotification = '';
  @observable String errorNotification = '';
}

