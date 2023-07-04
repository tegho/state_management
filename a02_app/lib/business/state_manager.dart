import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:datamodels/datamodels.dart';
import 'package:shopdata/shopdata.dart';
import '../business/cart.dart';

class StateManager with ChangeNotifier {
  late final DataService _dataService;
  late final Cart cart;
  List<String> _categories = [];
  int _categoriesNum = 0;

  /// categoryActive:
  /// empty - all categories
  /// or name
  String _categoryActive = '';
  ProductListModel _catalog = ProductListModel.empty();

  StateManager() {
    cart = Cart(notifyChangesCallback: stateChangedCallback);
    serviceProviderInit();
    _dataService = GetIt.I.get<DataService>();

    init();
  }

  void stateChangedCallback() {
    notifyListeners();
  }

  List<String> get categories => List<String>.from(_categories);

  int get categoriesNum => _categoriesNum;

  String get categoryActive => _categoryActive;

  set categoryActive(String cat) {
    if (cat != _categoryActive) {
      _catalog = ProductListModel.empty();
      _categoryActive = cat;
      stateChangedCallback();
    }
  }

  ProductListModel get catalog => _catalog;

  void init() {
    getCategories();
    getCatalog();
  }

  void getCategories() async {
    final resp = await _dataService.getCategories();
    if (resp is CategoriesListModel) {
      _categories = List<String>.from(resp.category);
      _categoriesNum = _categories.length;
      _categoryActive = '';
      stateChangedCallback();
      return;
    }
    _categories = [];
    _categoriesNum = 0;
    stateChangedCallback();
  }

  void getCatalog({String category = '', int more = 30}) async {
    final resp = await _dataService.getProductList(
        category: category, skip: _catalog.products.length, limit: more);
    if (resp is ProductListModel) {
      _catalog = ProductListModel(
          products: List<ProductModel>.from(_catalog.products)
            ..addAll(resp.products),
          skip: _catalog.products.length,
          limit: more,
          total: resp.total);
      stateChangedCallback();
      return;
    }
  }
}
