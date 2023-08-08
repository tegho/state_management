import 'package:mobx/mobx.dart';

import 'package:datamodels/datamodels.dart';
import 'package:shopdata/shopdata.dart';

import '/business/models/cart_item.dart';

part 'app_state.g.dart';

enum DrawersState { category, cart, none }

class AppState = AppStateBase with _$AppState;

abstract class AppStateBase with Store {
  final DataService _dataService;

  AppStateBase(this._dataService);

  @observable
  ProductListModel catalog = ProductListModel.empty();

  @observable
  CategoriesListModel categories = const CategoriesListModel();

  @observable
  String categorySelected = '';

  @observable
  bool categoryLoading = false;

  @observable
  bool catalogLoading = false;

  @observable
  DrawersState drawerOpened = DrawersState.none;

  @observable
  ProductModel? uiProductPage;

  @observable
  List<CartItem> cart = [];

  @computed
  double get cartSum {
    double sum = 0;

    for (final item in cart) {
      sum += item.count * item.product.price;
    }
    return sum;
  }

  @action
  void actionCartInit() {
    //
  }

  @action
  void actionCartClear() {
    cart = [];
  }

  @action
  void actionCartAdd({required ProductModel product, int count = 1}) {
    final List<CartItem> oldCart = List<CartItem>.from(cart);

    try {
      final CartItem item = oldCart.firstWhere((i) => i.product == product);
      final int index = oldCart.indexOf(item);
      final int newCount = item.count + count;
      if (newCount < 1) {
        oldCart.remove(item);
      } else {
        oldCart[index] = CartItem(product: product, count: newCount);
      }
    } catch (_) {
      if (count < 1) return;

      oldCart.add(CartItem(product: product, count: count));
    }
    cart = List<CartItem>.from(oldCart);
  }

  @action
  void actionCartRemove({required ProductModel product}) {
    final List<CartItem> oldCart = List<CartItem>.from(cart);
    try {
      final CartItem item = oldCart.firstWhere((i) => i.product == product);
      oldCart.remove(item);
      cart = List<CartItem>.from(oldCart);
    } catch (_) {}
  }

  @action
  void actionUiInit() {
    //
  }

  @action
  void actionUiSelectCategory({bool open = true}) {
    drawerOpened = (open) ? DrawersState.category : DrawersState.none;
  }

  @action
  void actionUiShowCart({bool open = true}) {
    drawerOpened = (open) ? DrawersState.cart : DrawersState.none;
  }

  @action
  void actionUiShowProduct({ProductModel? product}) {
    uiProductPage = product;
  }

  @action
  void actionShopCatalogClear() {
    catalogLoading = false;
    catalog = ProductListModel.empty();
  }

  @action
  void actionShopCategoriesClear() {
    categoryLoading = false;
    categories = const CategoriesListModel();
    categorySelected = '';
  }

  @action
  void actionShopCategoryChoose({String category = ''}) {
    categorySelected = category;
  }

  @action
  Future<dynamic> _actionShopCategoriesReload() async {
    actionShopCatalogClear();
    actionShopCatalogLoadMore();

    categoryLoading = true;
    final resp = await _dataService.getCategories();
    if (resp is CategoriesListModel) {
      categories = CategoriesListModel(category: resp.category);
    }
    categoryLoading = false;
  }

  @action
  Future<dynamic> _actionShopCatalogLoadMore(
      {String category = '', int skip = 0, int limit = 30}) async {
    catalogLoading = true;
    final resp = await _dataService.getProductList(
        category: category, skip: catalog.products.length, limit: limit);
    if (resp is ProductListModel) {
      catalog = catalog.copyWith(
        products: List<ProductModel>.from(catalog.products)
          ..addAll(resp.products),
        total: resp.total,
      );
    }
    catalogLoading = false;
  }

  void actionShopCategoriesReload() {
    _actionShopCategoriesReload();
  }

  void actionShopCatalogLoadMore(
      {String category = '', int skip = 0, int limit = 30}) {
    _actionShopCatalogLoadMore(category: category, skip: skip, limit: limit);
  }

  void actionShopInit() {
    actionShopCategoriesReload();
  }
}
