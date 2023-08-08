import 'package:get_it/get_it.dart';
import 'package:shopdata/shopdata.dart';

import '/business/state/app_state.dart';

export '/business/models/cart_item.dart';
export '/business/state/app_state.dart';

class BusinessProvider {
  late final DataService _dataService;
  late final AppState appState;

  BusinessProvider() {
    serviceProviderInit();
    _dataService = GetIt.I.get<DataService>();

    appState = AppState(_dataService);
  }
}
