import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:datamodels/datamodels.dart';

part 'ui_state.freezed.dart';

// part 'ui_state.g.dart';

enum DrawersState { category, cart, none }

@freezed
class UiState with _$UiState {
  const factory UiState({
    @Default(DrawersState.none) DrawersState drawerOpened,
    ProductModel? uiProductPage,
  }) = _UiState;

// factory UiState.fromJson(Map<String, Object?> json) =>
//     _$CartState(json);
}
