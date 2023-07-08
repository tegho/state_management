import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../business/providers.dart';

class CartDrawer extends ConsumerWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, _) {
            final cart = ref.watch(cartProvider);
            List<Widget> col = [];
            col.addAll(const [
              Padding(
                padding: EdgeInsets.only(top: 24, bottom: 20),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.shopping_cart, size: 45),
                ),
              ),
            ]);

            for (final cartItem in cart) {
              col.add(Card(
                elevation: 4,
                color: Colors.white70,
                child: ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .removeFromCart(product: cartItem.product);
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
                                ref.read(cartProvider.notifier).addToCart(
                                    product: cartItem.product, count: -1);
                              }),
                          Text(cartItem.count.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                ref.read(cartProvider.notifier).addToCart(
                                    product: cartItem.product, count: 1);
                              }),
                        ]),
                  ),
                ),
              ));
            }

            col.addAll([
              (cart.isEmpty)
                  ? const Text('Cart is empty')
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Total: ${ref.read(cartProvider.notifier).sum.toString()}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FilledButton(
                                child: const Text('Clear'),
                                onPressed: () {
                                  ref.read(cartProvider.notifier).clearCart();
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
                                                      Text(ref
                                                          .read(cartProvider
                                                              .notifier)
                                                          .sum
                                                          .toString()),
                                                    ],
                                                  ),
                                                )),
                                          ));
                                }),
                          ],
                        ),
                      ],
                    )
            ]);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: col,
            );
          },
        ),
      ),
    );
  }
}
