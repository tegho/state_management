import '../datamodels.dart';

class CategoriesListModel extends DataResponse {
  late final List<String> _category;

  CategoriesListModel({List<String> category = const []}) {
    _category = category;
  }

  List<String> get category => _category;
}
