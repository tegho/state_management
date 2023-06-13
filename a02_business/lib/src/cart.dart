import 'package:datamodels/datamodels.dart';

class CartItem {
  final ProductModel product;
  int count;

  CartItem({required this.product, required this.count});
}

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items {
    return List<CartItem>.from(_items);
  }

  void addToCart({required ProductModel product, int count = 1}) {
    for (final item in _items) {
      // compare just id to speed up
      if (item.product.id == product.id) {
        item.count += count;
        if (item.count < 1) {
          _items.remove(item);
        }
        return;
      }
    }

    if (count > 0) {
      _items.add(CartItem(product: product, count: count));
    }
  }

  void removeFromCart({required ProductModel product}) {
    for (final item in _items) {
      // compare just id to speed up
      if (item.product.id == product.id) {
        _items.remove(item);
        return;
      }
    }
  }
}
