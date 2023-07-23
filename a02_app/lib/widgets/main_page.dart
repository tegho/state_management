import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/business/state_manager.dart';

import '/widgets/cart_drawer.dart';
import '/widgets/category_selector.dart';
import '/widgets/product_tile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final ScrollController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  StateManager? stateManager;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      stateManager?.getCatalog(category: stateManager!.categoryActive);
    }
  }

  @override
  Widget build(BuildContext context) {
    stateManager = context.read<StateManager>();

    return Consumer<StateManager>(builder: (context, stateManager, child) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title:
              Consumer<StateManager>(builder: (context, stateManager, child) {
            return Text((stateManager.categoryActive.isEmpty)
                ? 'ALL'
                : stateManager.categoryActive.toUpperCase());
          }),
          actions: [
            Consumer<StateManager>(builder: (context, stateManager, child) {
              return SizedBox(
                width: 84,
                child: FilledButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(stateManager.cart.items.length.toString(),
                            style: const TextStyle(color: Colors.black)),
                        const Icon(Icons.shopping_cart),
                      ],
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    }),
              );
            }),
          ],
        ),
        drawer: CategorySelectorLeftDrawer(),
        endDrawer: const CartDrawer(),
        body: SafeArea(
          child: (stateManager.catalog.products.isEmpty)
              ? const Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  controller: controller,
                  itemCount: stateManager.catalog.total,
                  itemBuilder: (context, index) {
                    if (index > stateManager.catalog.products.length) {
                      return Container();
                    }
                    if (index == stateManager.catalog.products.length) {
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
                        left: 2,
                        right: 2,
                        top: 1,
                        bottom: 1,
                      ),
                      child: ProductTile(
                        product: stateManager.catalog.products[index],
                      ),
                    );
                  },
                ),
        ),
      );
    });
  }
}
