import 'package:datamodels/datamodels.dart';
import 'package:shopdata/shopdata.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/business/cart_item.dart';

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
    } finally {
      state = List<CartItem>.from(oldCart);
      _sumRecount();
    }
  }

  void removeFromCart({required ProductModel product}) {
    final List<CartItem> oldCart = List<CartItem>.from(state);

    try {
      final CartItem item = oldCart.firstWhere((i) => i.product == product);
      oldCart.remove(item);
      state = List<CartItem>.from(oldCart);
      _sumRecount();
    } catch (_) {}
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
