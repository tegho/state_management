import 'package:flutter/material.dart';

import 'package:datamodels/datamodels.dart';

import '/business/business_provider.dart';

import '/widgets/main_page.dart';

void main() {
  final BusinessProvider businessProvider = BusinessProvider();

  businessProvider.categoriesCubit.actionCategoriesInit();
  businessProvider.catalogCubit.actionCatalogInit();
  businessProvider.cartCubit.actionCartInit();
  businessProvider.uiCubit.actionUiInit();

  // // Test action from outside
  //
  // if (true) {
  //   Future.delayed(const Duration(seconds: 10), () {
  //     businessProvider.uiCubit.actionUiShowProduct(
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
  //     ));
  //   });
  // }

  runApp(MyApp(businessProvider: businessProvider));
}

class MyApp extends StatelessWidget {
  final BusinessProvider businessProvider;

  const MyApp({super.key, required this.businessProvider});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: businessProvider.uiCubit,
        ),
        BlocProvider.value(
          value: businessProvider.cartCubit,
        ),
        BlocProvider.value(
          value: businessProvider.categoriesCubit,
        ),
        BlocProvider.value(
          value: businessProvider.catalogCubit,
        ),
      ],
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
