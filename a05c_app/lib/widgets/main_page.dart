import 'dart:async';
import 'package:flutter/material.dart';

import '/business/business_provider.dart';

import '/widgets/category_selector.dart';
import '/widgets/cart_drawer.dart';
import '/widgets/product_tile.dart';
import '/widgets/product_info.dart';

//ignore: must_be_immutable
class MainPage extends StatelessWidget {
  MainPage({super.key});

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
                  product: state.uiProductPage!,
                )));
      }
    }

    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
    streamSubscription = context.read<UiCubit>().stream.listen(handleUiEvents);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: FilledButton(
            child: const Icon(Icons.category),
            onPressed: () {
              context.read<UiCubit>().actionUiSelectCategory(open: true);
            }),
        title: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, snapshot) {
            if (snapshot.list.category.isEmpty) {
              return const Text('Loading...');
            } else {
              return Text((snapshot.selected.isEmpty)
                  ? 'ALL'
                  : snapshot.selected.toUpperCase());
            }
          },
        ),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, snapshot) {
              int cartNum = snapshot.list.length;

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
                      context.read<UiCubit>().actionUiShowCart(open: true);
                    }),
              );
            },
          ),
        ],
      ),
      drawer: const CategorySelectorLeftDrawer(),
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          context.read<UiCubit>().actionUiSelectCategory(open: false);
        }
      },
      endDrawer: const CartDrawer(),
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          context.read<UiCubit>().actionUiShowCart(open: false);
        }
      },
      body: SafeArea(
        child: BlocBuilder<CatalogCubit, CatalogState>(
            builder: (context, snapshot) {
          if (snapshot.catalog.products.isEmpty) {
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
                    context.read<CatalogCubit>().actionCatalogLoadMore();
                  }
                }
                return false;
              },
              child: ListView.builder(
                controller: controller,
                itemCount: snapshot.catalog.total,
                itemBuilder: (context, index) {
                  if (index > snapshot.catalog.products.length) {
                    return Container();
                  }
                  if (index == snapshot.catalog.products.length) {
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
                      product: snapshot.catalog.products[index],
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
