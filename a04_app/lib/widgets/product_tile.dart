import 'package:flutter/material.dart';
import 'package:datamodels/datamodels.dart';
import '../widgets/product_info.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductInfo(
                  product: product,
                )));
      },
      child: Card(
        elevation: 4,
        color: Colors.greenAccent,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                // make card 3 strings height
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
