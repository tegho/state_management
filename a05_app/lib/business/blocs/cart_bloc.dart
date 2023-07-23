import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/business/actions/cart_actions.dart';
import '/business/states/cart_state.dart';
import '/business/models/cart_item.dart';

class CartBloc extends Bloc<ActionCart, CartState> {
  CartBloc() : super(const CartState()) {
    on<ActionCartInit>(_onActionCartInit);
    on<ActionCartClear>(_onActionCartClear);
    on<ActionCartPullState>(_onActionCartPullState);
    on<ActionCartAdd>(_onActionCartAdd);
    on<ActionCartRemove>(_onActionCartRemove);
  }

  Future<void> _onActionCartInit(
      ActionCartInit action, Emitter<CartState> emit) async {
    // emit(const CartState());
  }

  Future<void> _onActionCartClear(
      ActionCartClear action, Emitter<CartState> emit) async {
    emit(const CartState());
  }

  Future<void> _onActionCartPullState(
      ActionCartPullState action, Emitter<CartState> emit) async {
    emit(state);
  }

  Future<void> _onActionCartAdd(
      ActionCartAdd action, Emitter<CartState> emit) async {
    final List<CartItem> oldCart = List<CartItem>.from(state.list);

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
      if (action.count < 1) return;

      oldCart.add(CartItem(product: action.product, count: action.count));
    } finally {
      emit(state.copyWith(list: oldCart, sum: _sumRecount(oldCart)));
    }
  }

  Future<void> _onActionCartRemove(
      ActionCartRemove action, Emitter<CartState> emit) async {
    final List<CartItem> oldCart = List<CartItem>.from(state.list);
    try {
      final CartItem item =
          oldCart.firstWhere((i) => i.product == action.product);
      oldCart.remove(item);
      emit(state.copyWith(list: oldCart, sum: _sumRecount(oldCart)));
    } catch (_) {
      return;
    }
  }

  double _sumRecount(List<CartItem> items) {
    double sum = 0;

    for (final item in items) {
      sum += item.count * item.product.price;
    }
    return sum;
  }
}
