import 'dart:async';

import 'package:shopdata/shopdata.dart';
import 'package:datamodels/datamodels.dart';

import '/business/actions/catalog_actions.dart';
import '/business/states/catalog_state.dart';

class CatalogBloc {
  final DataService _dataService;

  CatalogState _currentState = const CatalogState();

  final _stateController = StreamController<CatalogState>.broadcast();
  final _actionsController = StreamController<ActionCatalog>();

  Stream<CatalogState> get state => _stateController.stream;

  Sink<ActionCatalog> get action => _actionsController.sink;

  CatalogBloc(this._dataService) {
    _actionsController.stream.listen(_handleAction);
  }

  void dispose() {
    _stateController.close();
    _actionsController.close();
  }

  void _handleAction(ActionCatalog action) async {
    switch (action.runtimeType) {
      case ActionCatalogClear:
        _currentState = const CatalogState();
        break;
      case ActionCatalogPullState:
        break;
      case ActionCatalogInit:
        _handleAction(ActionCatalogLoadMore());
        return;
      case ActionCatalogLoadMore:
        _stateController.add(_currentState);

        final resp = await _dataService.getProductList(
            category: (action as ActionCatalogLoadMore).category,
            skip: _currentState.catalog.products.length,
            limit: action.limit);

        if (resp is ProductListModel) {
          _currentState = _currentState.copyWith(
              catalog: _currentState.catalog.copyWith(
            products: List<ProductModel>.from(_currentState.catalog.products)
              ..addAll(resp.products),
            skip: _currentState.catalog.products.length,
            limit: action.limit,
            total: resp.total,
          ));
        }
        break;
      default:
        throw UnimplementedError(
            'Catalog action ${action.runtimeType.toString()} unimplemented');
    }

    _stateController.add(_currentState);
  }
}
