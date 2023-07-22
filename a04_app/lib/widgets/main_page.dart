import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:datamodels/datamodels.dart';
import '/business/providers.dart';
import '/widgets/product_tile.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProductListModel catalog = ref.watch(catalogProvider);

    final ScrollController controller = useScrollController();

    return (catalog.products.isEmpty)
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
                if (controller.offset >= controller.position.maxScrollExtent &&
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
          );
  }
}
