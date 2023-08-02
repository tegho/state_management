import 'package:redux/redux.dart';
import 'package:datamodels/datamodels.dart';
import 'package:shopdata/shopdata.dart';

import '/business/states/app_state.dart';
import '/business/actions/shop_actions.dart';

class ShopInitMiddleware implements MiddlewareClass<AppState> {
  ShopInitMiddleware();

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    store.dispatch(ActionShopCategoriesReload());
  }
}

class ShopCategoriesReloadMiddleware implements MiddlewareClass<AppState> {
  final DataService dataService;

  ShopCategoriesReloadMiddleware(this.dataService);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    store.dispatch(ActionShopCategoriesReloadStarted());
    store.dispatch(ActionShopCatalogClear());
    store.dispatch(ActionShopCatalogLoadMore());
    final resp = await dataService.getCategories();
    if (resp is CategoriesListModel) {
      store.dispatch(ActionShopCategoriesReloadSucceed(response: resp));
    } else {
      store.dispatch(ActionShopCategoriesReloadFailed());
    }
  }
}

class ShopCatalogLoadMoreMiddleware implements MiddlewareClass<AppState> {
  final DataService dataService;

  ShopCatalogLoadMoreMiddleware(this.dataService);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    store.dispatch(ActionShopCatalogLoadMoreStarted());

    final resp = await dataService.getProductList(
        category: action.category,
        skip: store.state.catalog.products.length,
        limit: action.limit);
    if (resp is ProductListModel) {
      store.dispatch(ActionShopCatalogLoadMoreSucceed(response: resp));
    } else {
      store.dispatch(ActionShopCatalogLoadMoreFailed());
    }
  }
}
