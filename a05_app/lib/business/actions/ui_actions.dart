import 'package:datamodels/datamodels.dart';

abstract class ActionUi {}

class ActionUiInit extends ActionUi {}

class ActionUiSelectCategory extends ActionUi {
  final bool open;

  ActionUiSelectCategory({this.open = false});
}

class ActionUiShowCart extends ActionUi {
  final bool open;

  ActionUiShowCart({this.open = false});
}

class ActionUiShowProduct extends ActionUi {
  final ProductModel? product;

  ActionUiShowProduct({this.product});
}
