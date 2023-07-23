import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:datamodels/datamodels.dart';

part 'categories_state.freezed.dart';

// part 'categories_state.g.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default(CategoriesListModel()) CategoriesListModel list,
    @Default('') String selected,
  }) = _CategoriesState;

// factory CategoriesState.fromJson(Map<String, Object?> json) =>
//     _$CategoriesStateFromJson(json);
}
