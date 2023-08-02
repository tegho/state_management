import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:datamodels/datamodels.dart';

import '/business/business_provider.dart';

import '/widgets/main_page.dart';

void main() {
  final BusinessProvider businessProvider = BusinessProvider();

  businessProvider.appStore.dispatch(ActionUiInit());
  businessProvider.appStore.dispatch(ActionCartInit());
  businessProvider.appStore.dispatch(ActionShopInit());

  // // Test action from outside
  //
  // if (true) {
  //   Future.delayed(const Duration(seconds: 10), () {
  //     businessProvider.appStore.dispatch(ActionUiShowProduct(product: null));
  //     businessProvider.appStore.dispatch(ActionUiShowProduct(
  //         product: ProductModel(
  //       id: 91,
  //       category: 'cat',
  //       title: 'test title',
  //       brand: 'abibas',
  //       description: 'descr',
  //       discountPercentage: 1,
  //       images: [],
  //       price: 100,
  //       rating: 1,
  //       stock: 2,
  //       thumbnail: '',
  //     )));
  //   });
  // }

  runApp(MyApp(businessProvider: businessProvider));
}

class MyApp extends StatelessWidget {
  final BusinessProvider businessProvider;

  const MyApp({super.key, required this.businessProvider});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: businessProvider.appStore,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}
