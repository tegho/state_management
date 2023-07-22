import 'dart:async';

import '/business/actions/ui_actions.dart';
import '/business/states/ui_state.dart';

import '/business/blocs/categories_bloc.dart';
import '/business/blocs/catalog_bloc.dart';
import '/business/blocs/cart_bloc.dart';

class UiBloc {
  final CategoriesBloc categoriesBloc;
  final CatalogBloc catalogBloc;
  final CartBloc cartBloc;

  UiState _currentState = const UiState();

  final _stateController = StreamController<UiState>.broadcast();
  final _actionsController = StreamController<ActionUi>();

  Stream<UiState> get state => _stateController.stream;

  Sink<ActionUi> get action => _actionsController.sink;

  UiBloc(
    this.categoriesBloc,
    this.catalogBloc,
    this.cartBloc,
  ) {
    _actionsController.stream.listen(_handleAction);
  }

  void dispose() {
    _stateController.close();
    _actionsController.close();
  }

  void _handleAction(ActionUi action) async {
    switch (action.runtimeType) {
      case ActionUiInit:
        // Feature: open cart by default
        // _currentState = _currentState.copyWith(drawerOpened: DrawersState.cart);
        break;

      case ActionUiSelectCategory:
        _currentState = _currentState.copyWith(
            drawerOpened: ((action as ActionUiSelectCategory).open)
                ? DrawersState.category
                : DrawersState.none);
        break;
      case ActionUiShowCart:
        _currentState = _currentState.copyWith(
            drawerOpened: ((action as ActionUiShowCart).open)
                ? DrawersState.cart
                : DrawersState.none);
        break;

      case ActionUiShowProduct:
        _currentState = _currentState.copyWith(
            uiProductPage: (action as ActionUiShowProduct).product);
        break;

      default:
        throw UnimplementedError(
            'Ui action ${action.runtimeType.toString()} unimplemented');
    }

    _stateController.add(_currentState);
  }
}
