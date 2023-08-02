import 'package:datamodels/datamodels.dart';

import '/business/states/app_state.dart';
import '/business/actions/shop_actions.dart';

AppState onActionShopCatalogClear(
    AppState state, ActionShopCatalogClear action) {
  return state.copyWith(
    lastAction: action,
    catalog: ProductListModel.empty(),
    catalogLoading: false,
  );
}

AppState onActionShopCategoriesClear(
    AppState state, ActionShopCategoriesClear action) {
  return state.copyWith(
    lastAction: action,
    categories: const CategoriesListModel(),
    categorySelected: '',
  );
}

AppState onActionShopCategoryChoose(
    AppState state, ActionShopCategoryChoose action) {
  return state.copyWith(
    lastAction: action,
    categorySelected: action.category,
  );
}

AppState onActionShopCategoriesReloadStarted(
    AppState state, ActionShopCategoriesReloadStarted action) {
  return state.copyWith(
    lastAction: action,
    categoryLoading: true,
  );
}

AppState onActionShopCategoriesReloadFailed(
    AppState state, ActionShopCategoriesReloadFailed action) {
  return state.copyWith(
    lastAction: action,
    categoryLoading: false,
  );
}

AppState onActionShopCategoriesReloadSucceed(
    AppState state, ActionShopCategoriesReloadSucceed action) {
  return state.copyWith(
    lastAction: action,
    categoryLoading: false,
    categories: action.response,
    categorySelected: '',
  );
}

AppState onActionShopCatalogLoadMoreStarted(
    AppState state, ActionShopCatalogLoadMoreStarted action) {
  return state.copyWith(
    lastAction: action,
    catalogLoading: true,
  );
}

AppState onActionShopCatalogLoadMoreFailed(
    AppState state, ActionShopCatalogLoadMoreFailed action) {
  return state.copyWith(
    lastAction: action,
    catalogLoading: false,
  );
}

AppState onActionShopCatalogLoadMoreSucceed(
    AppState state, ActionShopCatalogLoadMoreSucceed action) {
  return state.copyWith(
    lastAction: action,
    catalogLoading: false,
    catalog: state.catalog.copyWith(
      products: List<ProductModel>.from(state.catalog.products)
        ..addAll(action.response.products),
      total: action.response.total,
    ),
  );
}
