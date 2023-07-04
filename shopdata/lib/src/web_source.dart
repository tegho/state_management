import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:datamodels/datamodels.dart';
import '../shopdata.dart';

@LazySingleton(as: DataService)
class WebSource implements DataService {
  @override
  Future<DataResponse> getCategories() async {
    final url = 'https://dummyjson.com/products/categories';
    final String msgPrefix = 'Fetch categories:';
    String jsonRaw = '';

    try {
      jsonRaw = await http.read(Uri.parse(url));
    } on http.ClientException {
      return DataResponseError(message: '$msgPrefix Failed');
    } catch (_) {
      return DataResponseError(
          message: '$msgPrefix Incorrect URL or unknown error');
    }

    try {
      return CategoriesListModel(
          category: List<String>.from(jsonDecode(jsonRaw)));
    } catch (_) {
      return DataResponseError(message: '$msgPrefix Failed to parse json');
    }
  }

  @override
  Future<DataResponse> getProduct({required int id}) async {
    final url = 'https://dummyjson.com/products/$id';
    final String msgPrefix = 'Fetch product:';
    String jsonRaw = '';

    try {
      jsonRaw = await http.read(Uri.parse(url));
    } on http.ClientException {
      return DataResponseError(message: '$msgPrefix Failed');
    } catch (_) {
      return DataResponseError(
          message: '$msgPrefix Incorrect URL or unknown error');
    }

    try {
      return ProductModel.fromJson(jsonDecode(jsonRaw));
    } catch (_) {
      return DataResponseError(message: '$msgPrefix Failed to parse json');
    }
  }

  @override
  Future<DataResponse> getProductList(
      {String category = '', int skip = 0, int limit = 30}) async {
    final String msgPrefix = 'Fetch product list:';
    String jsonRaw = '';
    Map<String, dynamic>? queryParameters = {};

    if (limit != 0) {
      queryParameters.addAll({'limit': limit.toString()});
    }
    if (skip != 0) {
      queryParameters.addAll({'skip': skip.toString()});
    }
    if (queryParameters.isEmpty) queryParameters = null;

    final path =
        (category.isNotEmpty) ? 'products/category/$category' : 'products';

/////////////////
/// D E B U G ///
await Future.delayed(Duration(seconds: 2));
/////////////////
    try {
      final Uri uri = Uri.https('dummyjson.com', path, queryParameters);
      jsonRaw = await http.read(uri);
    } on http.ClientException {
      return DataResponseError(message: '$msgPrefix Failed');
    } catch (_) {
      return DataResponseError(
          message: '$msgPrefix Incorrect URL or unknown error');
    }

    try {
      return ProductListModel.fromJson(jsonDecode(jsonRaw));
    } catch (_) {
      return DataResponseError(message: '$msgPrefix Failed to parse json');
    }
  }
}
