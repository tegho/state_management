import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopdata/shopdata.dart';
import 'package:datamodels/datamodels.dart';

import '/business/actions/catalog_actions.dart';
import '/business/states/catalog_state.dart';

class CatalogBloc extends Bloc<ActionCatalog, CatalogState> {
  final DataService _dataService;

  CatalogBloc(this._dataService) : super(const CatalogState()) {
    on<ActionCatalogInit>(_onActionCatalogInit);
    on<ActionCatalogPullState>(_onActionCatalogPullState);
    on<ActionCatalogClear>(_onActionCatalogClear);
    on<ActionCatalogLoadMore>(_onActionCatalogLoadMore);
  }

  Future<void> _onActionCatalogInit(
      ActionCatalogInit action, Emitter<CatalogState> emit) async {
    add(ActionCatalogLoadMore());
  }

  Future<void> _onActionCatalogPullState(
      ActionCatalogPullState action, Emitter<CatalogState> emit) async {
    emit(state);
  }

  Future<void> _onActionCatalogClear(
      ActionCatalogClear action, Emitter<CatalogState> emit) async {
    emit(const CatalogState());
  }

  Future<void> _onActionCatalogLoadMore(
      ActionCatalogLoadMore action, Emitter<CatalogState> emit) async {
    emit(state);

    final resp = await _dataService.getProductList(
        category: action.category,
        skip: state.catalog.products.length,
        limit: action.limit);

    if (resp is ProductListModel) {
      emit(state.copyWith(
          catalog: state.catalog.copyWith(
        products: List<ProductModel>.from(state.catalog.products)
          ..addAll(resp.products),
        skip: state.catalog.products.length,
        limit: action.limit,
        total: resp.total,
      )));
    }
  }
}
