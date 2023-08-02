import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:datamodels/datamodels.dart';

import '/business/models/cart_item.dart';
import '/business/actions/common.dart';

part 'app_state.freezed.dart';

// part 'app_state.g.dart';

enum DrawersState { category, cart, none }

@freezed
class AppState with _$AppState {
  const factory AppState({
    AppActions? lastAction,
    @Default(ProductListModel(products: [], total: 0, skip: 0, limit: 0))
        ProductListModel catalog,
    @Default(CategoriesListModel()) CategoriesListModel categories,
    @Default('') String categorySelected,
    @Default(false) bool categoryLoading,
    @Default(false) bool catalogLoading,
    @Default(DrawersState.none) DrawersState drawerOpened,
    ProductModel? uiProductPage,
    @Default([]) List<CartItem> cart,
    @Default(0) double cartSum,
  }) = _AppState;

// factory AppState.fromJson(Map<String, Object?> json) =>
//     _$ShopState(json);
}
