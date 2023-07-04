import 'package:datamodels/datamodels.dart';

abstract class DataService {
  Future<DataResponse> getCategories();
  Future<DataResponse> getProductList({String category, int skip, int limit});
  Future<DataResponse> getProduct({required int id});
}
