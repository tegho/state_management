import 'package:datamodels/datamodels.dart';

abstract class ActionCart {}

class ActionCartInit extends ActionCart {}

class ActionCartPullState extends ActionCart {}

class ActionCartClear extends ActionCart {}

class ActionCartAdd extends ActionCart {
  final ProductModel product;
  final int count;

  ActionCartAdd({required this.product, this.count = 1});
}

class ActionCartRemove extends ActionCart {
  final ProductModel product;

  ActionCartRemove({required this.product});
}
