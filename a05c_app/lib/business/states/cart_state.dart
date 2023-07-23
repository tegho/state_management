import 'package:freezed_annotation/freezed_annotation.dart';

import '/business/models/cart_item.dart';

part 'cart_state.freezed.dart';

// part 'cart_state.g.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartItem> list,
    @Default(0) double sum,
  }) = _CartState;

// factory CartState.fromJson(Map<String, Object?> json) =>
//     _$CartState(json);
}
