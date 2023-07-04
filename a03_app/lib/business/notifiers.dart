import 'package:datamodels/datamodels.dart';
import 'package:shopdata/shopdata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../business/cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  double _sum = 0;

  double get sum => _sum;

  void _sumRecount() {
    _sum = 0;
    for (final item in state) {
      _sum += item.count * item.product.price;
    }
  }

  void addToCart({required ProductModel product, int count = 1}) {
    final List<CartItem> oldCart = List<CartItem>.from(state);

    for (final item in oldCart) {
      // compare just id to speed up
      if (item.product.id == product.id) {
        item.count += count;
        if (item.count < 1) {
          oldCart.remove(item);
        }
        state = List<CartItem>.from(oldCart);
        _sumRecount();
        return;
      }
    }

    if (count > 0) {
      oldCart.add(CartItem(product: product, count: count));
      state = List<CartItem>.from(oldCart);
      _sumRecount();
    }
  }

  void removeFromCart({required ProductModel product}) {
    final List<CartItem> oldCart = List<CartItem>.from(state);

    for (final item in oldCart) {
      // compare just id to speed up
      if (item.product.id == product.id) {
        oldCart.remove(item);
        state = List<CartItem>.from(oldCart);
        _sumRecount();
        return;
      }
    }
  }

  void clearCart() {
    if (state.isNotEmpty) {
      state = [];
      _sumRecount();
    }
  }
}

class CategoriesNotifier extends StateNotifier<List<String>> {
  late final DataService _dataService;

  CategoriesNotifier({required DataService dataService}) : super([]) {
    _dataService = dataService;
    getCategories();
  }

  void getCategories() async {
    final resp = await _dataService.getCategories();
    if (resp is CategoriesListModel) {
      state = List<String>.from(resp.category);
      return;
    }
    state = [];
  }
}

class CatalogNotifier extends StateNotifier<ProductListModel> {
  late final DataService _dataService;

  CatalogNotifier({required DataService dataService})
      : super(ProductListModel.empty()) {
    _dataService = dataService;
    getCatalog();
  }

  void clear() {
    state = ProductListModel.empty();
  }

  void getCatalog({String category = '', int more = 30}) async {
    final resp = await _dataService.getProductList(
        category: category, skip: state.products.length, limit: more);
    if (resp is ProductListModel) {
      state = ProductListModel(
          products: List<ProductModel>.from(state.products)
            ..addAll(resp.products),
          skip: state.products.length,
          limit: more,
          total: resp.total);
      return;
    }
  }
}
