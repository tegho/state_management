import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopdata/shopdata.dart';
import 'package:datamodels/datamodels.dart';

import '/business/actions/categories_actions.dart';
import '/business/states/categories_state.dart';

class CategoriesBloc extends Bloc<ActionCategories, CategoriesState> {
  final DataService _dataService;

  CategoriesBloc(this._dataService) : super(const CategoriesState()) {
    on<ActionCategoriesInit>(_onActionCategoriesInit);
    on<ActionCategoriesPullState>(_onActionCategoriesPullState);
    on<ActionCategoriesLoad>(_onActionCategoriesLoad);
    on<ActionCategoriesClear>(_onActionCategoriesClear);
    on<ActionCategoriesChoose>(_onActionCategoriesChoose);
  }

  Future<void> _onActionCategoriesInit(
      ActionCategoriesInit action, Emitter<CategoriesState> emit) async {
    add(ActionCategoriesLoad());
  }

  Future<void> _onActionCategoriesPullState(
      ActionCategoriesPullState action, Emitter<CategoriesState> emit) async {
    emit(state);
  }

  Future<void> _onActionCategoriesLoad(
      ActionCategoriesLoad action, Emitter<CategoriesState> emit) async {
    emit(state);
    final resp = await _dataService.getCategories();
    if (resp is CategoriesListModel) {
      emit(state.copyWith(
        selected: '',
        list: CategoriesListModel(category: List<String>.from(resp.category)),
      ));
    }
  }

  Future<void> _onActionCategoriesClear(
      ActionCategoriesClear action, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(
      selected: '',
      list: const CategoriesListModel(),
    ));
  }

  Future<void> _onActionCategoriesChoose(
      ActionCategoriesChoose action, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(
      selected: action.category,
    ));
  }
}
