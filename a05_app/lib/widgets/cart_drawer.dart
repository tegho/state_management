import 'package:flutter/material.dart';

import '/business/business_provider.dart';

class CartDrawer extends StatelessWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(ActionCartPullState());
    return BlocBuilder<CartBloc, CartState>(builder: (context, snapshot) {
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

      if (snapshot.list.isNotEmpty) {
        for (final cartItem in snapshot.list) {
          col.add(Card(
            elevation: 4,
            color: Colors.white70,
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () {
                  context
                      .read<CartBloc>()
                      .add(ActionCartRemove(product: cartItem.product));
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
                            context.read<CartBloc>().add(ActionCartAdd(
                                product: cartItem.product, count: -1));
                          }),
                      Text(cartItem.count.toString(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            context.read<CartBloc>().add(ActionCartAdd(
                                product: cartItem.product, count: 1));
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
                child: Text('Total: ${snapshot.sum.toString()}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                      child: const Text('Clear'),
                      onPressed: () {
                        context.read<CartBloc>().add(ActionCartClear());
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
                                            Text(snapshot.sum.toString()),
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
      // else {
      //   col.add(const Text('Loading...'));
      // }
      return Drawer(child: SingleChildScrollView(child: Column(children: col)));
    });
  }
}
