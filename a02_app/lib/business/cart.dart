import 'package:datamodels/datamodels.dart';

class CartItem {
  final ProductModel product;
  int count;

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
    for (final item in _items) {
      // compare just id to speed up
      if (item.product.id == product.id) {
        item.count += count;
        if (item.count < 1) {
          _items.remove(item);
        }
        _sumRecount();
        if (notifyChangesCallback != null) notifyChangesCallback!();
        return;
      }
    }

    if (count > 0) {
      _items.add(CartItem(product: product, count: count));
      _sumRecount();
      if (notifyChangesCallback != null) notifyChangesCallback!();
    }
  }

  void removeFromCart({required ProductModel product}) {
    for (final item in _items) {
      // compare just id to speed up
      if (item.product.id == product.id) {
        _items.remove(item);
        _sumRecount();
        if (notifyChangesCallback != null) notifyChangesCallback!();
        return;
      }
    }
  }

  void clearCart() {
    if (_items.isNotEmpty) {
      _items.clear();
      _sumRecount();
      if (notifyChangesCallback != null) notifyChangesCallback!();
    }
  }
}
