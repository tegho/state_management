// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on AppStateBase, Store {
  Computed<double>? _$cartSumComputed;

  @override
  double get cartSum => (_$cartSumComputed ??=
          Computed<double>(() => super.cartSum, name: 'AppStateBase.cartSum'))
      .value;

  late final _$catalogAtom =
      Atom(name: 'AppStateBase.catalog', context: context);

  @override
  ProductListModel get catalog {
    _$catalogAtom.reportRead();
    return super.catalog;
  }

  @override
  set catalog(ProductListModel value) {
    _$catalogAtom.reportWrite(value, super.catalog, () {
      super.catalog = value;
    });
  }

  late final _$categoriesAtom =
      Atom(name: 'AppStateBase.categories', context: context);

  @override
  CategoriesListModel get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(CategoriesListModel value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$categorySelectedAtom =
      Atom(name: 'AppStateBase.categorySelected', context: context);

  @override
  String get categorySelected {
    _$categorySelectedAtom.reportRead();
    return super.categorySelected;
  }

  @override
  set categorySelected(String value) {
    _$categorySelectedAtom.reportWrite(value, super.categorySelected, () {
      super.categorySelected = value;
    });
  }

  late final _$categoryLoadingAtom =
      Atom(name: 'AppStateBase.categoryLoading', context: context);

  @override
  bool get categoryLoading {
    _$categoryLoadingAtom.reportRead();
    return super.categoryLoading;
  }

  @override
  set categoryLoading(bool value) {
    _$categoryLoadingAtom.reportWrite(value, super.categoryLoading, () {
      super.categoryLoading = value;
    });
  }

  late final _$catalogLoadingAtom =
      Atom(name: 'AppStateBase.catalogLoading', context: context);

  @override
  bool get catalogLoading {
    _$catalogLoadingAtom.reportRead();
    return super.catalogLoading;
  }

  @override
  set catalogLoading(bool value) {
    _$catalogLoadingAtom.reportWrite(value, super.catalogLoading, () {
      super.catalogLoading = value;
    });
  }

  late final _$drawerOpenedAtom =
      Atom(name: 'AppStateBase.drawerOpened', context: context);

  @override
  DrawersState get drawerOpened {
    _$drawerOpenedAtom.reportRead();
    return super.drawerOpened;
  }

  @override
  set drawerOpened(DrawersState value) {
    _$drawerOpenedAtom.reportWrite(value, super.drawerOpened, () {
      super.drawerOpened = value;
    });
  }

  late final _$uiProductPageAtom =
      Atom(name: 'AppStateBase.uiProductPage', context: context);

  @override
  ProductModel? get uiProductPage {
    _$uiProductPageAtom.reportRead();
    return super.uiProductPage;
  }

  @override
  set uiProductPage(ProductModel? value) {
    _$uiProductPageAtom.reportWrite(value, super.uiProductPage, () {
      super.uiProductPage = value;
    });
  }

  late final _$cartAtom = Atom(name: 'AppStateBase.cart', context: context);

  @override
  List<CartItem> get cart {
    _$cartAtom.reportRead();
    return super.cart;
  }

  @override
  set cart(List<CartItem> value) {
    _$cartAtom.reportWrite(value, super.cart, () {
      super.cart = value;
    });
  }

  late final _$_actionShopCategoriesReloadAsyncAction =
      AsyncAction('AppStateBase._actionShopCategoriesReload', context: context);

  @override
  Future<dynamic> _actionShopCategoriesReload() {
    return _$_actionShopCategoriesReloadAsyncAction
        .run(() => super._actionShopCategoriesReload());
  }

  late final _$_actionShopCatalogLoadMoreAsyncAction =
      AsyncAction('AppStateBase._actionShopCatalogLoadMore', context: context);

  @override
  Future<dynamic> _actionShopCatalogLoadMore(
      {String category = '', int skip = 0, int limit = 30}) {
    return _$_actionShopCatalogLoadMoreAsyncAction.run(() => super
        ._actionShopCatalogLoadMore(
            category: category, skip: skip, limit: limit));
  }

  late final _$AppStateBaseActionController =
      ActionController(name: 'AppStateBase', context: context);

  @override
  void actionCartInit() {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionCartInit');
    try {
      return super.actionCartInit();
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionCartClear() {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionCartClear');
    try {
      return super.actionCartClear();
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionCartAdd({required ProductModel product, int count = 1}) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionCartAdd');
    try {
      return super.actionCartAdd(product: product, count: count);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionCartRemove({required ProductModel product}) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionCartRemove');
    try {
      return super.actionCartRemove(product: product);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionUiInit() {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionUiInit');
    try {
      return super.actionUiInit();
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionUiSelectCategory({bool open = true}) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionUiSelectCategory');
    try {
      return super.actionUiSelectCategory(open: open);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionUiShowCart({bool open = true}) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionUiShowCart');
    try {
      return super.actionUiShowCart(open: open);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionUiShowProduct({ProductModel? product}) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionUiShowProduct');
    try {
      return super.actionUiShowProduct(product: product);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionShopCatalogClear() {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionShopCatalogClear');
    try {
      return super.actionShopCatalogClear();
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionShopCategoriesClear() {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionShopCategoriesClear');
    try {
      return super.actionShopCategoriesClear();
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void actionShopCategoryChoose({String category = ''}) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.actionShopCategoryChoose');
    try {
      return super.actionShopCategoryChoose(category: category);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
catalog: ${catalog},
categories: ${categories},
categorySelected: ${categorySelected},
categoryLoading: ${categoryLoading},
catalogLoading: ${catalogLoading},
drawerOpened: ${drawerOpened},
uiProductPage: ${uiProductPage},
cart: ${cart},
cartSum: ${cartSum}
    ''';
  }
}
