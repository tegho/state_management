import 'package:freezed_annotation/freezed_annotation.dart';

import '../datamodels.dart';

part 'product_list_model.freezed.dart';

part 'product_list_model.g.dart';

@freezed
class ProductListModel extends DataResponse with _$ProductListModel {
  const factory ProductListModel({
    required List<ProductModel> products,
    required int total,
    required int skip,
    required int limit,
  }) = _ProductListModel;

  factory ProductListModel.empty() =>
      ProductListModel(products: [], total: 0, skip: 0, limit: 0);

  factory ProductListModel.fromJson(Map<String, Object?> json) =>
      _$ProductListModelFromJson(json);
}
