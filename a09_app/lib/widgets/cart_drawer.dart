import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '/business/business_provider.dart';

class CartDrawer extends StatelessWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Observer(builder: (context) {
      List<Widget> col = [];

      col.add(
        const Padding(
          padding: EdgeInsets.only(top: 24, bottom: 20),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.green,
            child: Icon(Icons.shopping_cart, size: 45),
          ),
        ),
      );

      if (appState.cart.isNotEmpty) {
        for (final cartItem in appState.cart) {
          col.add(Card(
            elevation: 4,
            color: Colors.white70,
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () {
                  appState.actionCartRemove(product: cartItem.product);
                },
              ),
              title: Text(cartItem.product.title),
              subtitle: Text(
                  '${cartItem.count.toString()} x ${cartItem.product.price.toString()} = ${cartItem.product.price * cartItem.count}'),
              trailing: SizedBox(
                width: 110,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            appState.actionCartAdd(
                                product: cartItem.product, count: -1);
                          }),
                      Text(cartItem.count.toString(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            appState.actionCartAdd(
                                product: cartItem.product, count: 1);
                          }),
                    ]),
              ),
            ),
          ));
        }

        col.addAll([
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total: ${appState.cartSum.toString()}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                      child: const Text('Clear'),
                      onPressed: () {
                        appState.actionCartClear();
                      }),
                  FilledButton(
                      child: const Text('Checkout'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Pay me!'),
                                  content: SizedBox(
                                      height: 100,
                                      child: Card(
                                        child: Row(
                                          children: [
                                            const Text('Total: '),
                                            Text(appState.cartSum.toString()),
                                          ],
                                        ),
                                      )),
                                ));
                      }),
                ],
              ),
            ],
          ),
        ]);
      } else {
        col.add(const Text('Empty cart'));
      }
      return Drawer(child: SingleChildScrollView(child: Column(children: col)));
    });
  }
}
