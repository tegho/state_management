import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datamodels/datamodels.dart';

import '/business/states/ui_state.dart';

class UiCubit extends Cubit<UiState> {
  UiCubit() : super(const UiState());

  Future<void> actionUiInit() async {
    // Feature: open cart by default
    // emit(state.copyWith(drawerOpened: DrawersState.cart));
  }

  Future<void> actionUiSelectCategory({bool open = false}) async {
    emit(
      state.copyWith(
          drawerOpened: (open) ? DrawersState.category : DrawersState.none),
    );
  }

  Future<void> actionUiShowCart({bool open = false}) async {
    emit(
      state.copyWith(
          drawerOpened: (open) ? DrawersState.cart : DrawersState.none),
    );
  }

  Future<void> actionUiShowProduct({ProductModel? product}) async {
    emit(state.copyWith(uiProductPage: null));
    if (product != null) {
      emit(state.copyWith(uiProductPage: product));
    }
  }
}
