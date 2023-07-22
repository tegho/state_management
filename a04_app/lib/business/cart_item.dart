import 'package:datamodels/datamodels.dart';

class CartItem {
  final ProductModel product;
  final int count;

  CartItem({required this.product, required this.count});
}
