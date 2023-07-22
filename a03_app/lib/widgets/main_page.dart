import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datamodels/datamodels.dart';
import '/business/providers.dart';
import '/widgets/product_tile.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late final ScrollController controller;

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
      ref.read(catalogProvider.notifier).getCatalog();
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductListModel catalog = ref.watch(catalogProvider);

    return (catalog.products.isEmpty)
        ? const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          )
        : ListView.builder(
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
                  left: 2,
                  right: 2,
                  top: 1,
                  bottom: 1,
                ),
                child: ProductTile(
                  product: catalog.products[index],
                ),
              );
            },
          );
  }
}
