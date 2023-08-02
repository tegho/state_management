import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '/business/business_provider.dart';

import '/widgets/product_info.dart';

import '/widgets/containers/catalog_title.dart';
import '/widgets/containers/cart_action_button.dart';
import '/widgets/containers/category_selector.dart';
import '/widgets/containers/cart_drawer.dart';
import '/widgets/containers/catalog_viewer.dart';

//ignore: must_be_immutable
class MainPage extends StatelessWidget {
  MainPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? streamSubscription;

  @override
  Widget build(BuildContext context) {
    void handleUiEvents(AppState state) {
      if ((scaffoldKey.currentState == null)) {
        return;
      }

      switch (state.drawerOpened) {
        case DrawersState.category:
          scaffoldKey.currentState!.closeEndDrawer();
          scaffoldKey.currentState!.openDrawer();
          break;
        case DrawersState.cart:
          scaffoldKey.currentState!.closeDrawer();
          scaffoldKey.currentState!.openEndDrawer();
          break;
        case DrawersState.none:
          scaffoldKey.currentState!.closeDrawer();
          scaffoldKey.currentState!.closeEndDrawer();
          break;
        default:
          throw UnimplementedError('Unknown drawer state');
      }

      if ((state.lastAction is ActionUiShowProduct) &&
          (state.uiProductPage != null)) {
        Navigator.of(context).push(MaterialPageRoute(
          maintainState: false,
          builder: (context) => ProductInfo(
            product: state.uiProductPage!,
          ),
        ));
      }
    }

    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
    streamSubscription =
        StoreProvider.of<AppState>(context).onChange.listen(handleUiEvents);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: FilledButton(
            child: const Icon(Icons.category),
            onPressed: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(ActionUiSelectCategory(open: true));
            }),
        title: const CatalogTitle(),
        actions: const [
          SizedBox(
            width: 84,
            child: CartActionButton(),
          ),
        ],
      ),
      drawer: const CategorySelectorLeftDrawer(),
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          StoreProvider.of<AppState>(context)
              .dispatch(ActionUiSelectCategory(open: false));
        }
      },
      endDrawer: const CartDrawer(),
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          StoreProvider.of<AppState>(context)
              .dispatch(ActionUiShowCart(open: false));
        }
      },
      body: SafeArea(
        child: CatalogViewer(),
      ),
    );
  }
}
