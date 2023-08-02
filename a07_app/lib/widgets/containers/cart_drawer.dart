import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '/business/business_provider.dart';

import '/business/models/cart_item.dart';

part 'cart_drawer.freezed.dart';

class CartDrawer extends StatelessWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
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

          if (vm.cart.isNotEmpty) {
            for (final cartItem in vm.cart) {
              col.add(Card(
                elevation: 4,
                color: Colors.white70,
                child: ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    onPressed: () {
                      StoreProvider.of<AppState>(context).dispatch(
                          ActionCartRemove(product: cartItem.product));
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
                                StoreProvider.of<AppState>(context).dispatch(
                                    ActionCartAdd(
                                        product: cartItem.product, count: -1));
                              }),
                          Text(cartItem.count.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                StoreProvider.of<AppState>(context).dispatch(
                                    ActionCartAdd(
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
                    child: Text('Total: ${vm.cartSum.toString()}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton(
                          child: const Text('Clear'),
                          onPressed: () {
                            StoreProvider.of<AppState>(context)
                                .dispatch(ActionCartClear());
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
                                                Text(vm.cartSum.toString()),
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
          return Drawer(
              child: SingleChildScrollView(child: Column(children: col)));
        });
  }
}

@freezed
class _ViewModel with _$_ViewModel {
  const factory _ViewModel({
    required List<CartItem> cart,
    required double cartSum,
  }) = __ViewModel;

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        cart: store.state.cart,
        cartSum: store.state.cartSum,
      );
}
