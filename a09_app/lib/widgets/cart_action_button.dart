import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '/business/business_provider.dart';

class CartActionButton extends StatelessWidget {
  const CartActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final appState = Provider.of<AppState>(context);
        return FilledButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(appState.cart.length.toString(),
                    style: const TextStyle(color: Colors.black)),
                const Icon(Icons.shopping_cart),
              ],
            ),
            onPressed: () {
              appState.actionUiShowCart(open: true);
            });
      },
    );
  }
}
