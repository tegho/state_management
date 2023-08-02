import '/business/models/cart_item.dart';
import '/business/states/app_state.dart';
import '/business/actions/cart_actions.dart';

AppState onActionCartInit(AppState state, ActionCartInit action) {
  return state.copyWith(
    lastAction: action,
  );
}

AppState onActionCartClear(AppState state, ActionCartClear action) {
  return state.copyWith(
    lastAction: action,
    cartSum: 0,
    cart: [],
  );
}

AppState onActionCartAdd(AppState state, ActionCartAdd action) {
  final List<CartItem> oldCart = List<CartItem>.from(state.cart);

  try {
    final CartItem item =
        oldCart.firstWhere((i) => i.product == action.product);
    final int index = oldCart.indexOf(item);
    final int newCount = item.count + action.count;
    if (newCount < 1) {
      oldCart.remove(item);
    } else {
      oldCart[index] = CartItem(product: action.product, count: newCount);
    }
  } catch (_) {
    if (action.count < 1) return state;

    oldCart.add(CartItem(product: action.product, count: action.count));
  }
  return state.copyWith(
    lastAction: action,
    cart: oldCart,
    cartSum: _sumRecount(oldCart),
  );
}

AppState onActionCartRemove(AppState state, ActionCartRemove action) {
  final List<CartItem> oldCart = List<CartItem>.from(state.cart);
  try {
    final CartItem item =
        oldCart.firstWhere((i) => i.product == action.product);
    oldCart.remove(item);
    return state.copyWith(
      lastAction: action,
      cart: oldCart,
      cartSum: _sumRecount(oldCart),
    );
  } catch (_) {
    return state;
  }
}

double _sumRecount(List<CartItem> items) {
  double sum = 0;

  for (final item in items) {
    sum += item.count * item.product.price;
  }
  return sum;
}
