import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:datamodels/datamodels.dart';
import 'package:shopdata/shopdata.dart';

import '/business/blocs/categories_bloc.dart';
import '/business/blocs/catalog_bloc.dart';
import '/business/blocs/cart_bloc.dart';

import '/business/actions/categories_actions.dart';
import '/business/actions/catalog_actions.dart';
import '/business/actions/cart_actions.dart';

import '/business/states/categories_state.dart';
import '/business/states/catalog_state.dart';
import '/business/states/cart_state.dart';

part 'ui_state.freezed.dart';

// part 'ui_state.g.dart';

enum DrawersState { category, cart, none }

@freezed
class UiState with _$UiState {
  const factory UiState({
    @Default(CartState()) CartState cartState,
    @Default(CatalogState()) CatalogState catalogState,
    @Default(CategoriesState()) CategoriesState categoriesState,
    @Default(DrawersState.none) DrawersState drawerOpened,
    ProductModel? uiProductPage,
  }) = _UiState;

// factory UiState.fromJson(Map<String, Object?> json) =>
//     _$CartState(json);
}
