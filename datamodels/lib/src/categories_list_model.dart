import '/datamodels.dart';

class CategoriesListModel extends DataResponse {
  final List<String> category;

  const CategoriesListModel({this.category = const []});
}
