import 'dart:async';

import '/business/actions/cart_actions.dart';
import '/business/states/cart_state.dart';
import '/business/models/cart_item.dart';

class CartBloc {
  CartState _currentState = const CartState();

  final _stateController = StreamController<CartState>.broadcast();
  final _actionsController = StreamController<ActionCart>();

  Stream<CartState> get state => _stateController.stream;

  Sink<ActionCart> get action => _actionsController.sink;

  CartBloc() {
    _actionsController.stream.listen(_handleAction);
  }

  void dispose() {
    _stateController.close();
    _actionsController.close();
  }

  double _sumRecount(List<CartItem> items) {
    double sum = 0;

    for (final item in items) {
      sum += item.count * item.product.price;
    }
    return sum;
  }

  void _handleAction(ActionCart action) async {
    switch (action.runtimeType) {
      case ActionCartInit:
        return;
      case ActionCartClear:
        _currentState = const CartState();
        break;
      case ActionCartPullState:
        break;
      case ActionCartAdd:
        final List<CartItem> oldCart = List<CartItem>.from(_currentState.list);
        try {
          final CartItem item = oldCart.firstWhere(
              (i) => i.product == (action as ActionCartAdd).product);
          final int index = oldCart.indexOf(item);
          final int newCount = item.count + (action as ActionCartAdd).count;
          if (newCount < 1) {
            oldCart.remove(item);
          } else {
            oldCart[index] = CartItem(
                product: (action as ActionCartAdd).product, count: newCount);
          }
        } catch (_) {
          if ((action as ActionCartAdd).count < 1) return;

          oldCart.add(CartItem(
              product: (action as ActionCartAdd).product,
              count: (action as ActionCartAdd).count));
        } finally {
          _currentState =
              _currentState.copyWith(list: oldCart, sum: _sumRecount(oldCart));
        }
        break;

      case ActionCartRemove:
        final List<CartItem> oldCart = List<CartItem>.from(_currentState.list);
        try {
          final CartItem item = oldCart.firstWhere(
              (i) => i.product == (action as ActionCartRemove).product);
          oldCart.remove(item);
          _currentState =
              _currentState.copyWith(list: oldCart, sum: _sumRecount(oldCart));
        } catch (_) {
          return;
        }
        break;

      default:
        throw UnimplementedError(
            'Cart action ${action.runtimeType.toString()} unimplemented');
    }

    _stateController.add(_currentState);
  }
}
