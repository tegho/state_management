import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:shopdata/shopdata.dart';

import '/business/actions/shop_actions.dart';
import '/business/states/app_state.dart';
import '/business/middlewares/shop_middlewares.dart';
import '/business/reducers/reducers.dart';

export '/business/actions/shop_actions.dart';
export '/business/actions/cart_actions.dart';
export '/business/actions/ui_actions.dart';

export '/business/states/app_state.dart';

class BusinessProvider {
  late final DataService _dataService;

  late final Store<AppState> appStore;

  BusinessProvider() {
    serviceProviderInit();
    _dataService = GetIt.I.get<DataService>();

    appStore = Store<AppState>(stateReducer,
        initialState: const AppState(),
        middleware: [
          TypedMiddleware<AppState, ActionShopInit>(ShopInitMiddleware()),
          TypedMiddleware<AppState, ActionShopCategoriesReload>(
              ShopCategoriesReloadMiddleware(_dataService)),
          TypedMiddleware<AppState, ActionShopCatalogLoadMore>(
              ShopCatalogLoadMoreMiddleware(_dataService)),
        ]);
  }
}
