import 'package:datamodels/datamodels.dart';

class CartItem {
  final ProductModel product;
  final int count;

  CartItem({required this.product, required this.count});
}

class Cart {
  final List<CartItem> _items = [];
  final Function()? notifyChangesCallback;
  double _sum = 0;

  List<CartItem> get items {
    return List<CartItem>.from(_items);
  }

  double get sum {
    return _sum;
  }

  Cart({this.notifyChangesCallback});

  void _sumRecount() {
    _sum = 0;
    for (final item in _items) {
      _sum += item.count * item.product.price;
    }
  }

  void addToCart({required ProductModel product, int count = 1}) {
    try {
      final CartItem item = _items.firstWhere((i) => i.product == product);
      final int index = _items.indexOf(item);
      final int newCount = item.count + count;
      if (newCount < 1) {
        _items.remove(item);
      } else {
        _items[index] = CartItem(product: product, count: newCount);
      }
    } catch (_) {
      if (count < 1) return;
      _items.add(CartItem(product: product, count: count));
    } finally {
      _sumRecount();
      if (notifyChangesCallback != null) notifyChangesCallback!();
    }
  }

  void removeFromCart({required ProductModel product}) {
    try {
      final CartItem item = _items.firstWhere((i) => i.product == product);
      _items.remove(item);
      _sumRecount();
      if (notifyChangesCallback != null) notifyChangesCallback!();
    } catch (_) {}
  }

  void clearCart() {
    if (_items.isNotEmpty) {
      _items.clear();
      _sumRecount();
      if (notifyChangesCallback != null) notifyChangesCallback!();
    }
  }
}
