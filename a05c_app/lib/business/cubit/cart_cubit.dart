import 'dart:async';
import 'package:datamodels/datamodels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/business/states/cart_state.dart';
import '/business/models/cart_item.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  Future<void> actionCartInit() async {
    // emit(const CartState());
  }

  Future<void> actionCartClear() async {
    emit(const CartState());
  }

  Future<void> actionCartPullState() async {
    emit(state);
  }

  Future<void> actionCartAdd(
      {required ProductModel product, int count = 1}) async {
    final List<CartItem> oldCart = List<CartItem>.from(state.list);

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
      emit(state.copyWith(list: oldCart, sum: _sumRecount(oldCart)));
    }
  }

  Future<void> actionCartRemove({required ProductModel product}) async {
    final List<CartItem> oldCart = List<CartItem>.from(state.list);
    try {
      final CartItem item = oldCart.firstWhere((i) => i.product == product);
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
