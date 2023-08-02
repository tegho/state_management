import 'package:redux/redux.dart';

import '/business/states/app_state.dart';

import '/business/actions/shop_actions.dart';
import '/business/actions/cart_actions.dart';
import '/business/actions/ui_actions.dart';

import '/business/reducers/cart_reducers.dart';
import '/business/reducers/ui_reducers.dart';
import '/business/reducers/shop_reducers.dart';

final stateReducer = combineReducers<AppState>([
  TypedReducer<AppState, ActionUiInit>(onActionUiInit),
  TypedReducer<AppState, ActionUiSelectCategory>(onActionUiSelectCategory),
  TypedReducer<AppState, ActionUiShowCart>(onActionUiShowCart),
  TypedReducer<AppState, ActionUiShowProduct>(onActionUiShowProduct),
  TypedReducer<AppState, ActionCartInit>(onActionCartInit),
  TypedReducer<AppState, ActionCartClear>(onActionCartClear),
  TypedReducer<AppState, ActionCartAdd>(onActionCartAdd),
  TypedReducer<AppState, ActionCartRemove>(onActionCartRemove),
  TypedReducer<AppState, ActionShopCatalogClear>(onActionShopCatalogClear),
  TypedReducer<AppState, ActionShopCategoriesClear>(
      onActionShopCategoriesClear),
  TypedReducer<AppState, ActionShopCategoryChoose>(onActionShopCategoryChoose),
  TypedReducer<AppState, ActionShopCategoriesReloadStarted>(
      onActionShopCategoriesReloadStarted),
  TypedReducer<AppState, ActionShopCategoriesReloadFailed>(
      onActionShopCategoriesReloadFailed),
  TypedReducer<AppState, ActionShopCategoriesReloadSucceed>(
      onActionShopCategoriesReloadSucceed),
  TypedReducer<AppState, ActionShopCatalogLoadMoreStarted>(
      onActionShopCatalogLoadMoreStarted),
  TypedReducer<AppState, ActionShopCatalogLoadMoreFailed>(
      onActionShopCatalogLoadMoreFailed),
  TypedReducer<AppState, ActionShopCatalogLoadMoreSucceed>(
      onActionShopCatalogLoadMoreSucceed),
]);
