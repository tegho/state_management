import 'dart:async';
import 'package:flutter/material.dart';

import '/business/business_provider.dart';

import '/widgets/category_selector.dart';
import '/widgets/cart_drawer.dart';
import '/widgets/product_tile.dart';
import '/widgets/product_info.dart';

//ignore: must_be_immutable
class MainPage extends StatelessWidget {
  MainPage({super.key, required this.businessProvider});

  final BusinessProvider businessProvider;
  final ScrollController controller = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? streamSubscription;

  @override
  Widget build(BuildContext context) {
    void handleUiEvents(UiState state) {
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

      if (state.uiProductPage != null) {
        Navigator.of(context).push(MaterialPageRoute(
            maintainState: false,
            builder: (context) => ProductInfo(
                  businessProvider: businessProvider,
                  product: state.uiProductPage!,
                )));
      }
    }

    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
    streamSubscription = businessProvider.uiBloc.state.listen(handleUiEvents);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: FilledButton(
            child: const Icon(Icons.category),
            onPressed: () {
              businessProvider.uiBloc.action
                  .add(ActionUiSelectCategory(open: true));
            }),
        title: StreamBuilder<CategoriesState>(
          stream: businessProvider.categoriesBloc.state,
          builder: (context, snapshot) {
            if ((!snapshot.hasData) ||
                ((snapshot.hasData) &&
                    (snapshot.data!.list.category.isEmpty))) {
              return const Text('Loading...');
            } else {
              return Text((snapshot.data!.selected.isEmpty)
                  ? 'ALL'
                  : snapshot.data!.selected.toUpperCase());
            }
          },
        ),
        actions: [
          StreamBuilder<CartState>(
            stream: businessProvider.cartBloc.state,
            builder: (context, snapshot) {
              int cartNum = 0;

              if (snapshot.hasData) {
                cartNum = snapshot.data!.list.length;
              }

              return SizedBox(
                width: 84,
                child: FilledButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(cartNum.toString(),
                            style: const TextStyle(color: Colors.black)),
                        const Icon(Icons.shopping_cart),
                      ],
                    ),
                    onPressed: () {
                      businessProvider.uiBloc.action
                          .add(ActionUiShowCart(open: true));
                    }),
              );
            },
          ),
        ],
      ),
      drawer: CategorySelectorLeftDrawer(businessProvider: businessProvider),
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          businessProvider.uiBloc.action
              .add(ActionUiSelectCategory(open: false));
        }
      },
      endDrawer: CartDrawer(businessProvider: businessProvider),
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          businessProvider.uiBloc.action.add(ActionUiShowCart(open: false));
        }
      },
      body: SafeArea(
        child: StreamBuilder<CatalogState>(
            stream: businessProvider.catalogBloc.state,
            builder: (context, snapshot) {
              if ((!snapshot.hasData) ||
                  ((snapshot.hasData) &&
                      (snapshot.data!.catalog.products.isEmpty))) {
                return const Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification) {
                      if (controller.offset >=
                              controller.position.maxScrollExtent &&
                          !controller.position.outOfRange) {
                        businessProvider.catalogBloc.action
                            .add(ActionCatalogLoadMore());
                      }
                    }
                    return false;
                  },
                  child: ListView.builder(
                    controller: controller,
                    itemCount: snapshot.data!.catalog.total,
                    itemBuilder: (context, index) {
                      if (index > snapshot.data!.catalog.products.length) {
                        return Container();
                      }
                      if (index == snapshot.data!.catalog.products.length) {
                        return const Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 1, bottom: 1),
                        child: ProductTile(
                          businessProvider: businessProvider,
                          product: snapshot.data!.catalog.products[index],
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ),
    );
  }
}
