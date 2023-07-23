import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:datamodels/datamodels.dart';

part 'catalog_state.freezed.dart';

// part 'catalog_state.g.dart';

@freezed
class CatalogState with _$CatalogState {
  const factory CatalogState({
    @Default(ProductListModel(products: [], total: 0, skip: 0, limit: 0))
        ProductListModel catalog,
  }) = _CatalogState;

// factory CartState.fromJson(Map<String, Object?> json) =>
//     _$CartState(json);
}
