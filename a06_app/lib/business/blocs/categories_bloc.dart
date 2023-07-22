import 'dart:async';

import 'package:shopdata/shopdata.dart';
import 'package:datamodels/datamodels.dart';

import '/business/actions/categories_actions.dart';
import '/business/states/categories_state.dart';

class CategoriesBloc {
  final DataService _dataService;

  CategoriesState _currentState = const CategoriesState();

  final _stateController = StreamController<CategoriesState>.broadcast();
  final _actionsController = StreamController<ActionCategories>();

  Stream<CategoriesState> get state => _stateController.stream;

  Sink<ActionCategories> get action => _actionsController.sink;

  CategoriesBloc(this._dataService) {
    _actionsController.stream.listen(_handleAction);
  }

  void dispose() {
    _stateController.close();
    _actionsController.close();
  }

  void _handleAction(ActionCategories action) async {
    switch (action.runtimeType) {
      case ActionCategoriesInit:
        _handleAction(ActionCategoriesLoad());
        return;
      case ActionCategoriesLoad:
        _stateController.add(_currentState);

        final resp = await _dataService.getCategories();
        if (resp is CategoriesListModel) {
          _currentState = _currentState.copyWith(
            selected: '',
            list:
                CategoriesListModel(category: List<String>.from(resp.category)),
          );
        }
        break;
      case ActionCategoriesClear:
        _currentState = _currentState.copyWith(
          selected: '',
          list: const CategoriesListModel(),
        );
        break;
      case ActionCategoriesPullState:
        break;
      case ActionCategoriesChoose:
        _currentState = _currentState.copyWith(
          selected: (action as ActionCategoriesChoose).category,
        );
        break;
      default:
        throw UnimplementedError(
            'Category action ${action.runtimeType.toString()} unimplemented');
    }

    _stateController.add(_currentState);
  }
}
