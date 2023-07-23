import 'package:datamodels/datamodels.dart';

import 'package:flutter/material.dart';

import '/business/business_provider.dart';

import '/widgets/main_page.dart';

void main() {
  final BusinessProvider businessProvider = BusinessProvider();

  businessProvider.categoriesBloc.action.add(ActionCategoriesInit());
  businessProvider.catalogBloc.action.add(ActionCatalogInit());
  businessProvider.cartBloc.action.add(ActionCartInit());
  businessProvider.uiBloc.action.add(ActionUiInit());

  // // Test action from outside
  //
  // if (true) {
  //   Future.delayed(const Duration(seconds: 10), () {
  //     businessProvider.uiBloc.action.add(ActionUiShowProduct(
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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(businessProvider: businessProvider),
    );
  }
}
