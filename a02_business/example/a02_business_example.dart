import 'package:datamodels/datamodels.dart';
import 'package:a02_business/business.dart';
import 'package:get_it/get_it.dart';

void main() async {
  GlobalState state = GlobalState();
  //
  // final p1 = ProductModel(
  //   id: 10,
  //   title: 'aa',
  //   description: 'aa1',
  //   price: 5,
  //   discountPercentage: 0,
  //   rating: 1,
  //   stock: 10,
  //   brand: 'aa2',
  //   category: 'cat1',
  //   thumbnail: '',
  //   images: List.empty(),
  // );
  businessProviderInit();
  final logic = GetIt.I.get<StateManagerMobile>();

  final p1 = await logic.prod(id: 1) as ProductModel;
  final p2 = await logic.prod(id: 2) as ProductModel;

  state.cart.addToCart(
    product: p1,
    count: 2,
  );
  state.cart.addToCart(
    product: p2,
    count: 4,
  );
  // state.cart.addToCart(
  //   product: p1,
  //   count: -1,
  // );
  // state.cart.removeFromCart(product: p2);
  //
  for (final i in state.cart.items) {
    print('${i.product.title} = ${i.count}');
  }
}
