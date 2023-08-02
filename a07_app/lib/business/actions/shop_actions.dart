import 'package:datamodels/datamodels.dart';
import '/business/actions/common.dart';

abstract class ActionShop extends AppActions {}

class ActionShopInit extends ActionShop {}

class ActionShopCatalogClear extends ActionShop {}

class ActionShopCategoriesClear extends ActionShop {}

class ActionShopCategoryChoose extends ActionShop {
  final String category;

  ActionShopCategoryChoose({this.category = ''});
}

class ActionShopCategoriesReload extends ActionShop {}

class ActionShopCategoriesReloadStarted extends ActionShop {}

class ActionShopCategoriesReloadFailed extends ActionShop {}

class ActionShopCategoriesReloadSucceed extends ActionShop {
  final CategoriesListModel response;

  ActionShopCategoriesReloadSucceed(
      {this.response = const CategoriesListModel()});
}

class ActionShopCatalogLoadMore extends ActionShop {
  final int skip;
  final int limit;
  final String category;

  ActionShopCatalogLoadMore(
      {this.category = '', this.skip = 0, this.limit = 30});
}

class ActionShopCatalogLoadMoreStarted extends ActionShop {}

class ActionShopCatalogLoadMoreFailed extends ActionShop {}

class ActionShopCatalogLoadMoreSucceed extends ActionShop {
  final ProductListModel response;

  ActionShopCatalogLoadMoreSucceed(
      {this.response =
          const ProductListModel(products: [], skip: 0, limit: 0, total: 0)});
}
