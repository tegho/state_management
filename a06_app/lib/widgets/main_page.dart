import 'package:flutter/material.dart';

import '/business/blocs/ui_bloc.dart';
import '/business/actions/catalog_actions.dart';
import '/business/actions/ui_actions.dart';
import '/business/states/catalog_state.dart';
import '/business/states/ui_state.dart';

import '/widgets/product_tile.dart';
import '/widgets/product_info.dart';

class MainPage extends StatelessWidget {
  final UiBloc uiBloc;

  const MainPage({super.key, required this.uiBloc});

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();

    void handleProductPage(UiState state) {
      if (state.uiProductPage != null) {
        uiBloc.action.add(ActionUiShowProduct(product: null));

        Navigator.of(context).push(MaterialPageRoute(
            maintainState: false,
            builder: (context) => ProductInfo(
                  uiBloc: uiBloc,
                  product: state.uiProductPage!,
                )));
      }
    }

    uiBloc.state.listen(handleProductPage);

    return StreamBuilder<CatalogState>(
        stream: uiBloc.catalogBloc.state,
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
                    uiBloc.catalogBloc.action.add(ActionCatalogLoadMore());
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
                      uiBloc: uiBloc,
                      product: snapshot.data!.catalog.products[index],
                    ),
                  );
                },
              ),
            );
          }
        });
  }
}
