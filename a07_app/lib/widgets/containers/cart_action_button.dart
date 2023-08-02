import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '/business/business_provider.dart';

part 'cart_action_button.freezed.dart';

class CartActionButton extends StatelessWidget {
  const CartActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {

        return FilledButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(vm.cartNum.toString(),
                    style: const TextStyle(color: Colors.black)),
                const Icon(Icons.shopping_cart),
              ],
            ),
            onPressed: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(ActionUiShowCart(open: true));
            });
      },
    );
  }
}

@freezed
class _ViewModel with _$_ViewModel {
  const factory _ViewModel({
    required int cartNum,
  }) = __ViewModel;

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        cartNum: store.state.cart.length,
      );
}
