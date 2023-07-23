import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:datamodels/datamodels.dart';

import '/business/providers.dart';

import '/widgets/product_tile.dart';
import '/widgets/cart_drawer.dart';
import '/widgets/category_selector.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProductListModel catalog = ref.watch(catalogProvider);

    final ScrollController controller = useScrollController();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, _) {
            final activeCategory = ref.watch(activeCategoryProvider);

            return Text((activeCategory.isEmpty)
                ? 'ALL'
                : activeCategory.toUpperCase());
          },
        ),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final cart = ref.watch(cartProvider);

              return SizedBox(
                width: 84,
                child: FilledButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(cart.length.toString(),
                            style: const TextStyle(color: Colors.black)),
                        const Icon(Icons.shopping_cart),
                      ],
                    ),
                    onPressed: () {
                      scaffoldKey.currentState!.openEndDrawer();
                    }),
              );
            },
          ),
        ],
      ),
      drawer: CategorySelectorLeftDrawer(),
      endDrawer: const CartDrawer(),
      body: SafeArea(
        child: (catalog.products.isEmpty)
            ? const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              )
            : NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    if (controller.offset >=
                            controller.position.maxScrollExtent &&
                        !controller.position.outOfRange) {
                      ref.read(catalogProvider.notifier).getCatalog();
                    }
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: controller,
                  itemCount: catalog.total,
                  itemBuilder: (context, index) {
                    if (index > catalog.products.length) {
                      return Container();
                    }
                    if (index == catalog.products.length) {
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
                        product: catalog.products[index],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
