import 'dart:async';

import '/business/actions/ui_actions.dart';
import '/business/states/ui_state.dart';

class UiBloc {
  UiState _currentState = const UiState();

  final _stateController = StreamController<UiState>.broadcast();
  final _actionsController = StreamController<ActionUi>();

  Stream<UiState> get state => _stateController.stream;

  Sink<ActionUi> get action => _actionsController.sink;

  UiBloc() {
    _actionsController.stream.listen(_handleAction);
  }

  void dispose() {
    _stateController.close();
    _actionsController.close();
  }

  void _handleAction(ActionUi action) async {
    switch (action.runtimeType) {
      case ActionUiInit:
        // Feature: open cart on app start
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
        // First close info if another product has already been opened.
        // The case when ActionUiShowProduct has been received from outside.
        _currentState = _currentState.copyWith(uiProductPage: null);
        _stateController.add(_currentState);

        if ((action as ActionUiShowProduct).product != null) {
          _currentState = _currentState.copyWith(
              uiProductPage: (action as ActionUiShowProduct).product);
        }
        break;

      default:
        throw UnimplementedError(
            'Ui action ${action.runtimeType.toString()} unimplemented');
    }

    _stateController.add(_currentState);
  }
}
