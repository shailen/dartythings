import 'package:polymer/polymer.dart';

@CustomTag('searchable-list')
class SearchableList extends PolymerElement {
  @observable bool applyAuthorStyles = true;
  @observable String searchParam;
  List<String> data = [];
  final List<String> results = toObservable([]);

  SearchableList.created() : super.created() {
    polymerCreated();
  }

  enteredView() {
    super.enteredView();
    results.addAll(data);
    //onPropertyChange(this, #searchParam, search);
  }

  search() {
    results.clear();
    String lower = searchParam.toLowerCase();
    results.addAll(data.where((String term) {
      return term.toLowerCase().contains(lower);
    }));
  }
}