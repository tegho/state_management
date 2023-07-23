import 'package:get_it/get_it.dart';
import 'package:shopdata/shopdata.dart';

import '/business/cubit/categories_cubit.dart';
import '/business/cubit/catalog_cubit.dart';
import '/business/cubit/cart_cubit.dart';
import '/business/cubit/ui_cubit.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

export '/business/cubit/categories_cubit.dart';
export '/business/cubit/catalog_cubit.dart';
export '/business/cubit/cart_cubit.dart';
export '/business/cubit/ui_cubit.dart';

export '/business/states/categories_state.dart';
export '/business/states/catalog_state.dart';
export '/business/states/cart_state.dart';
export '/business/states/ui_state.dart';

class BusinessProvider {
  late final DataService _dataService;
  late final CategoriesCubit categoriesCubit;
  late final CatalogCubit catalogCubit;
  late final CartCubit cartCubit;
  late final UiCubit uiCubit;

  BusinessProvider() {
    serviceProviderInit();
    _dataService = GetIt.I.get<DataService>();

    uiCubit = UiCubit();
    cartCubit = CartCubit();
    categoriesCubit = CategoriesCubit(_dataService);
    catalogCubit = CatalogCubit(_dataService);
  }
}
