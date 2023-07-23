import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopdata/shopdata.dart';
import 'package:datamodels/datamodels.dart';

import '/business/states/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final DataService _dataService;

  CategoriesCubit(this._dataService) : super(const CategoriesState());

  Future<void> actionCategoriesInit() async {
    actionCategoriesLoad();
  }

  Future<void> actionCategoriesPullState() async {
    emit(state);
  }

  Future<void> actionCategoriesLoad() async {
    emit(state);
    final resp = await _dataService.getCategories();
    if (resp is CategoriesListModel) {
      emit(state.copyWith(
        selected: '',
        list: CategoriesListModel(category: List<String>.from(resp.category)),
      ));
    }
  }

  Future<void> actionCategoriesClear() async {
    emit(state.copyWith(
      selected: '',
      list: const CategoriesListModel(),
    ));
  }

  Future<void> actionCategoriesChoose({String category = ''}) async {
    emit(state.copyWith(
      selected: category,
    ));
  }
}
