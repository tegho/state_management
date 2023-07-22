import 'package:datamodels/datamodels.dart';
import 'package:shopdata/shopdata.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/business/cart_item.dart';
import '/business/notifiers.dart';

final serviceProvider = Provider((ref) {
  serviceProviderInit();
  return GetIt.I.get<DataService>();
});

final catalogProvider =
    StateNotifierProvider<CatalogNotifier, ProductListModel>(
  (ref) => CatalogNotifier(dataService: ref.read(serviceProvider)),
);

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<String>>(
  (ref) => CategoriesNotifier(dataService: ref.read(serviceProvider)),
);

final activeCategoryProvider = StateProvider<String>(
  (ref) => '',
);

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
