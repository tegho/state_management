// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppState {
  AppActions? get lastAction => throw _privateConstructorUsedError;
  ProductListModel get catalog => throw _privateConstructorUsedError;
  CategoriesListModel get categories => throw _privateConstructorUsedError;
  String get categorySelected => throw _privateConstructorUsedError;
  bool get categoryLoading => throw _privateConstructorUsedError;
  bool get catalogLoading => throw _privateConstructorUsedError;
  DrawersState get drawerOpened => throw _privateConstructorUsedError;
  ProductModel? get uiProductPage => throw _privateConstructorUsedError;
  List<CartItem> get cart => throw _privateConstructorUsedError;
  double get cartSum => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {AppActions? lastAction,
      ProductListModel catalog,
      CategoriesListModel categories,
      String categorySelected,
      bool categoryLoading,
      bool catalogLoading,
      DrawersState drawerOpened,
      ProductModel? uiProductPage,
      List<CartItem> cart,
      double cartSum});

  $ProductListModelCopyWith<$Res> get catalog;
  $ProductModelCopyWith<$Res>? get uiProductPage;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastAction = freezed,
    Object? catalog = null,
    Object? categories = null,
    Object? categorySelected = null,
    Object? categoryLoading = null,
    Object? catalogLoading = null,
    Object? drawerOpened = null,
    Object? uiProductPage = freezed,
    Object? cart = null,
    Object? cartSum = null,
  }) {
    return _then(_value.copyWith(
      lastAction: freezed == lastAction
          ? _value.lastAction
          : lastAction // ignore: cast_nullable_to_non_nullable
              as AppActions?,
      catalog: null == catalog
          ? _value.catalog
          : catalog // ignore: cast_nullable_to_non_nullable
              as ProductListModel,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as CategoriesListModel,
      categorySelected: null == categorySelected
          ? _value.categorySelected
          : categorySelected // ignore: cast_nullable_to_non_nullable
              as String,
      categoryLoading: null == categoryLoading
          ? _value.categoryLoading
          : categoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      catalogLoading: null == catalogLoading
          ? _value.catalogLoading
          : catalogLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      drawerOpened: null == drawerOpened
          ? _value.drawerOpened
          : drawerOpened // ignore: cast_nullable_to_non_nullable
              as DrawersState,
      uiProductPage: freezed == uiProductPage
          ? _value.uiProductPage
          : uiProductPage // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      cart: null == cart
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      cartSum: null == cartSum
          ? _value.cartSum
          : cartSum // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductListModelCopyWith<$Res> get catalog {
    return $ProductListModelCopyWith<$Res>(_value.catalog, (value) {
      return _then(_value.copyWith(catalog: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res>? get uiProductPage {
    if (_value.uiProductPage == null) {
      return null;
    }

    return $ProductModelCopyWith<$Res>(_value.uiProductPage!, (value) {
      return _then(_value.copyWith(uiProductPage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$$_AppStateCopyWith(
          _$_AppState value, $Res Function(_$_AppState) then) =
      __$$_AppStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppActions? lastAction,
      ProductListModel catalog,
      CategoriesListModel categories,
      String categorySelected,
      bool categoryLoading,
      bool catalogLoading,
      DrawersState drawerOpened,
      ProductModel? uiProductPage,
      List<CartItem> cart,
      double cartSum});

  @override
  $ProductListModelCopyWith<$Res> get catalog;
  @override
  $ProductModelCopyWith<$Res>? get uiProductPage;
}

/// @nodoc
class __$$_AppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_AppState>
    implements _$$_AppStateCopyWith<$Res> {
  __$$_AppStateCopyWithImpl(
      _$_AppState _value, $Res Function(_$_AppState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastAction = freezed,
    Object? catalog = null,
    Object? categories = null,
    Object? categorySelected = null,
    Object? categoryLoading = null,
    Object? catalogLoading = null,
    Object? drawerOpened = null,
    Object? uiProductPage = freezed,
    Object? cart = null,
    Object? cartSum = null,
  }) {
    return _then(_$_AppState(
      lastAction: freezed == lastAction
          ? _value.lastAction
          : lastAction // ignore: cast_nullable_to_non_nullable
              as AppActions?,
      catalog: null == catalog
          ? _value.catalog
          : catalog // ignore: cast_nullable_to_non_nullable
              as ProductListModel,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as CategoriesListModel,
      categorySelected: null == categorySelected
          ? _value.categorySelected
          : categorySelected // ignore: cast_nullable_to_non_nullable
              as String,
      categoryLoading: null == categoryLoading
          ? _value.categoryLoading
          : categoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      catalogLoading: null == catalogLoading
          ? _value.catalogLoading
          : catalogLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      drawerOpened: null == drawerOpened
          ? _value.drawerOpened
          : drawerOpened // ignore: cast_nullable_to_non_nullable
              as DrawersState,
      uiProductPage: freezed == uiProductPage
          ? _value.uiProductPage
          : uiProductPage // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      cart: null == cart
          ? _value._cart
          : cart // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      cartSum: null == cartSum
          ? _value.cartSum
          : cartSum // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_AppState implements _AppState {
  const _$_AppState(
      {this.lastAction,
      this.catalog =
          const ProductListModel(products: [], total: 0, skip: 0, limit: 0),
      this.categories = const CategoriesListModel(),
      this.categorySelected = '',
      this.categoryLoading = false,
      this.catalogLoading = false,
      this.drawerOpened = DrawersState.none,
      this.uiProductPage,
      final List<CartItem> cart = const [],
      this.cartSum = 0})
      : _cart = cart;

  @override
  final AppActions? lastAction;
  @override
  @JsonKey()
  final ProductListModel catalog;
  @override
  @JsonKey()
  final CategoriesListModel categories;
  @override
  @JsonKey()
  final String categorySelected;
  @override
  @JsonKey()
  final bool categoryLoading;
  @override
  @JsonKey()
  final bool catalogLoading;
  @override
  @JsonKey()
  final DrawersState drawerOpened;
  @override
  final ProductModel? uiProductPage;
  final List<CartItem> _cart;
  @override
  @JsonKey()
  List<CartItem> get cart {
    if (_cart is EqualUnmodifiableListView) return _cart;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cart);
  }

  @override
  @JsonKey()
  final double cartSum;

  @override
  String toString() {
    return 'AppState(lastAction: $lastAction, catalog: $catalog, categories: $categories, categorySelected: $categorySelected, categoryLoading: $categoryLoading, catalogLoading: $catalogLoading, drawerOpened: $drawerOpened, uiProductPage: $uiProductPage, cart: $cart, cartSum: $cartSum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppState &&
            (identical(other.lastAction, lastAction) ||
                other.lastAction == lastAction) &&
            (identical(other.catalog, catalog) || other.catalog == catalog) &&
            (identical(other.categories, categories) ||
                other.categories == categories) &&
            (identical(other.categorySelected, categorySelected) ||
                other.categorySelected == categorySelected) &&
            (identical(other.categoryLoading, categoryLoading) ||
                other.categoryLoading == categoryLoading) &&
            (identical(other.catalogLoading, catalogLoading) ||
                other.catalogLoading == catalogLoading) &&
            (identical(other.drawerOpened, drawerOpened) ||
                other.drawerOpened == drawerOpened) &&
            (identical(other.uiProductPage, uiProductPage) ||
                other.uiProductPage == uiProductPage) &&
            const DeepCollectionEquality().equals(other._cart, _cart) &&
            (identical(other.cartSum, cartSum) || other.cartSum == cartSum));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      lastAction,
      catalog,
      categories,
      categorySelected,
      categoryLoading,
      catalogLoading,
      drawerOpened,
      uiProductPage,
      const DeepCollectionEquality().hash(_cart),
      cartSum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      __$$_AppStateCopyWithImpl<_$_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {final AppActions? lastAction,
      final ProductListModel catalog,
      final CategoriesListModel categories,
      final String categorySelected,
      final bool categoryLoading,
      final bool catalogLoading,
      final DrawersState drawerOpened,
      final ProductModel? uiProductPage,
      final List<CartItem> cart,
      final double cartSum}) = _$_AppState;

  @override
  AppActions? get lastAction;
  @override
  ProductListModel get catalog;
  @override
  CategoriesListModel get categories;
  @override
  String get categorySelected;
  @override
  bool get categoryLoading;
  @override
  bool get catalogLoading;
  @override
  DrawersState get drawerOpened;
  @override
  ProductModel? get uiProductPage;
  @override
  List<CartItem> get cart;
  @override
  double get cartSum;
  @override
  @JsonKey(ignore: true)
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
