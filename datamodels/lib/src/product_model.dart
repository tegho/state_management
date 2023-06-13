import 'package:freezed_annotation/freezed_annotation.dart';
import '../datamodels.dart';

part 'product_model.freezed.dart';

part 'product_model.g.dart';

@freezed
class ProductModel extends DataResponse with _$ProductModel {
  @Assert('id > 0', 'Product ID  must be above zero.')
  @Assert('price > 0', 'Product price must be above zero.')
  @Assert('title.isNotEmpty', 'Product must have title')
  factory ProductModel({
    required int id,
    required String title,
    required String description,
    required double price,
    required double discountPercentage,
    required double rating,
    required double stock,
    required String brand,
    required String category,
    required String thumbnail,
    required List<String> images,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, Object?> json) =>
      _$ProductModelFromJson(json);
}
