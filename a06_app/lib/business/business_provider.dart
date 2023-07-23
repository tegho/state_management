import 'package:get_it/get_it.dart';
import 'package:shopdata/shopdata.dart';

import '/business/blocs/categories_bloc.dart';
import '/business/blocs/catalog_bloc.dart';
import '/business/blocs/cart_bloc.dart';
import '/business/blocs/ui_bloc.dart';

export '/business/blocs/categories_bloc.dart';
export '/business/blocs/catalog_bloc.dart';
export '/business/blocs/cart_bloc.dart';
export '/business/blocs/ui_bloc.dart';

export '/business/actions/categories_actions.dart';
export '/business/actions/catalog_actions.dart';
export '/business/actions/cart_actions.dart';
export '/business/actions/ui_actions.dart';

export '/business/states/categories_state.dart';
export '/business/states/catalog_state.dart';
export '/business/states/cart_state.dart';
export '/business/states/ui_state.dart';

class BusinessProvider {
  late final DataService _dataService;
  late final CategoriesBloc categoriesBloc;
  late final CatalogBloc catalogBloc;
  late final CartBloc cartBloc;
  late final UiBloc uiBloc;

  BusinessProvider() {
    serviceProviderInit();
    _dataService = GetIt.I.get<DataService>();

    uiBloc = UiBloc();
    cartBloc = CartBloc();
    categoriesBloc = CategoriesBloc(_dataService);
    catalogBloc = CatalogBloc(_dataService);
  }
}
