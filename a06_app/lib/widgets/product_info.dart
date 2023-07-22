import 'dart:async';
import 'package:flutter/material.dart';

import 'package:datamodels/datamodels.dart';

import '/business/blocs/ui_bloc.dart';
import '/business/actions/cart_actions.dart';
import '/business/actions/ui_actions.dart';
import '/business/states/ui_state.dart';

import '/widgets/image_viewer.dart';

class ProductInfo extends StatelessWidget {
  final ProductModel product;
  final UiBloc uiBloc;

  const ProductInfo({super.key, required this.uiBloc, required this.product});

  @override
  Widget build(BuildContext context) {
    late final StreamSubscription streamSubscription;

    void handleCloseAction(UiState state) {
      if (state.uiProductPage == null) {
        streamSubscription.cancel();
        Navigator.of(context).pop();
      }
    }

    streamSubscription = uiBloc.state.listen(handleCloseAction);

    String titleShort = (product.title.length > 20)
        ? '${product.title.substring(0, 17)}...'
        : product.title;

    return WillPopScope(
      onWillPop: () {
        uiBloc.action.add(ActionUiShowProduct(product: null));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(titleShort),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  height: MediaQuery.of(context).size.height / 3,
                  child: ImageViewer(product: product),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(product.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(product.description,
                        style: const TextStyle(fontSize: 14))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Brand: ${product.brand}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Category: ${product.category}',
                        style: const TextStyle(fontSize: 14))),
                Container(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 18),
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text('Price: ${product.price}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          child: Row(
                            children: const [
                              Icon(Icons.add_shopping_cart),
                              Text('Add'),
                            ],
                          ),
                          onPressed: () {
                            uiBloc.cartBloc.action
                                .add(ActionCartAdd(product: product));
                            uiBloc.action
                                .add(ActionUiShowProduct(product: null));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
