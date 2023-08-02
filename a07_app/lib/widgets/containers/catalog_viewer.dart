import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:datamodels/datamodels.dart';

import '/business/business_provider.dart';

import '/widgets/product_tile.dart';

part 'catalog_viewer.freezed.dart';

class CatalogViewer extends StatelessWidget {
  CatalogViewer({super.key});

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          if (vm.catalog.products.isEmpty) {
            if (vm.catalogLoading) {
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
                  if (controller.offset >=
                          controller.position.maxScrollExtent &&
                      !controller.position.outOfRange) {
                    StoreProvider.of<AppState>(context)
                        .dispatch(ActionShopCatalogLoadMore());
                  }
                }
                return false;
              },
              child: ListView.builder(
                controller: controller,
                itemCount: vm.catalog.total,
                itemBuilder: (context, index) {
                  if (index > vm.catalog.products.length) {
                    return Container();
                  }
                  if (index == vm.catalog.products.length) {
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
                      product: vm.catalog.products[index],
                    ),
                  );
                },
              ),
            );
          }
        });
  }
}

@freezed
class _ViewModel with _$_ViewModel {
  const factory _ViewModel({
    required bool catalogLoading,
    required ProductListModel catalog,
  }) = __ViewModel;

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        catalogLoading: store.state.catalogLoading,
        catalog: store.state.catalog,
      );
}
