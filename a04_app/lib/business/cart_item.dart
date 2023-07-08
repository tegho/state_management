import 'package:datamodels/datamodels.dart';

class CartItem {
  final ProductModel product;
  int count;

  CartItem({required this.product, required this.count});
}
