import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopdata/shopdata.dart';
import 'package:datamodels/datamodels.dart';

import '/business/states/catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final DataService _dataService;

  CatalogCubit(this._dataService) : super(const CatalogState());

  Future<void> actionCatalogInit() async {
    actionCatalogLoadMore();
  }

  Future<void> actionCatalogPullState() async {
    emit(state);
  }

  Future<void> actionCatalogClear() async {
    emit(const CatalogState());
  }

  Future<void> actionCatalogLoadMore(
      {String category = '', int skip = 0, int limit = 30}) async {
    emit(state);

    final resp = await _dataService.getProductList(
        category: category, skip: state.catalog.products.length, limit: limit);

    if (resp is ProductListModel) {
      emit(state.copyWith(
          catalog: state.catalog.copyWith(
        products: List<ProductModel>.from(state.catalog.products)
          ..addAll(resp.products),
        skip: state.catalog.products.length,
        limit: limit,
        total: resp.total,
      )));
    }
  }
}
