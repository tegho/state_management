import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '/business/business_provider.dart';
import '/widgets/product_tile.dart';

class CatalogViewer extends StatelessWidget {
  CatalogViewer({super.key});

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (context) {
      if (appState.catalog.products.isEmpty) {
        if (appState.catalogLoading) {
          return const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Text('Nothing here');
        }
      } else {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification) {
              if (controller.offset >= controller.position.maxScrollExtent &&
                  !controller.position.outOfRange) {
                appState.actionShopCatalogLoadMore();
              }
            }
            return false;
          },
          child: ListView.builder(
            controller: controller,
            itemCount: appState.catalog.total,
            itemBuilder: (context, index) {
              if (index > appState.catalog.products.length) {
                return Container();
              }
              if (index == appState.catalog.products.length) {
                return const Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.only(left: 2, right: 2, top: 1, bottom: 1),
                child: ProductTile(
                  product: appState.catalog.products[index],
                ),
              );
            },
          ),
        );
      }
    });
  }
}
