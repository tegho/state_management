import 'package:flutter/material.dart';

import 'package:datamodels/datamodels.dart';

import '/business/blocs/ui_bloc.dart';
import '/business/actions/ui_actions.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final UiBloc uiBloc;

  const ProductTile({super.key, required this.uiBloc, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        uiBloc.action.add(ActionUiShowProduct(product: product));
      },
      child: Card(
        elevation: 4,
        color: Colors.greenAccent,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                // make card 3 strings in height
                children: const [Text(''), Text(''), Text('')],
              ),
            ),
            Expanded(
                flex: 90,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(product.title))),
            Expanded(
                flex: 30,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(product.price.toString()))),
          ],
        ),
      ),
    );
  }
}
