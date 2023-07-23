import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/business/actions/ui_actions.dart';
import '/business/states/ui_state.dart';

class UiBloc extends Bloc<ActionUi, UiState> {
  UiBloc() : super(const UiState()) {
    on<ActionUiInit>(_onActionUiInit);
    on<ActionUiSelectCategory>(_onActionUiSelectCategory);
    on<ActionUiShowCart>(_onActionUiShowCart);
    on<ActionUiShowProduct>(_onActionUiShowProduct);
  }

  Future<void> _onActionUiInit(
      ActionUiInit action, Emitter<UiState> emit) async {
    // Feature: open cart by default
    // emit(state.copyWith(drawerOpened: DrawersState.cart));
  }

  Future<void> _onActionUiSelectCategory(
      ActionUiSelectCategory action, Emitter<UiState> emit) async {
    emit(
      state.copyWith(
          drawerOpened:
              (action.open) ? DrawersState.category : DrawersState.none),
    );
  }

  Future<void> _onActionUiShowCart(
      ActionUiShowCart action, Emitter<UiState> emit) async {
    emit(
      state.copyWith(
          drawerOpened: (action.open) ? DrawersState.cart : DrawersState.none),
    );
  }

  Future<void> _onActionUiShowProduct(
      ActionUiShowProduct action, Emitter<UiState> emit) async {
    emit(state.copyWith(uiProductPage: null));
    if (action.product != null) {
      emit(state.copyWith(uiProductPage: action.product));
    }
  }
}
