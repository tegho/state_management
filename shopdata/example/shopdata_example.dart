import 'package:datamodels/datamodels.dart';
import 'package:shopdata/src/web_source.dart';

void main() async {
  // // Backend limits the list length to 30 by default
  // final i = await WebSource().getProductList();
  // final i = await WebSource().getProductList(limit: 31);
  // if ( i is DataResponseError ) {
  //   print(i.message);
  // } else {
  //   print((i as ProductListModel).toString());
  // }


  // final i = await WebSource().getProduct(id: 3);
  // if ( i is DataResponseError ) {
  //   print(i.message);
  // } else {
  //   print((i as ProductModel).toString());
  // }

  // final i = await WebSource().getCategories();
  // if ( i is DataResponseError ) {
  //   print(i.message);
  // } else {
  //   print((i as CategoriesListModel).category);
  // }
}
