import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:datamodels/datamodels.dart';

import '/business/business_provider.dart';

part 'category_selector.freezed.dart';

class CategorySelectorLeftDrawer extends StatelessWidget {
  const CategorySelectorLeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double swipePositionStart = 0;
    double swipePositionLast = 0;

    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          List<Widget> col = [];
          col.add(GestureDetector(
            onPanEnd: (details) {
              // swipe down reloads categories
              if (swipePositionStart - swipePositionLast < 0) {
                // print('swipe down');
                StoreProvider.of<AppState>(context)
                    .dispatch(ActionShopCategoriesReload());
              }
            },
            onPanDown: (details) {
              swipePositionStart = details.globalPosition.dy;
            },
            onPanUpdate: (details) {
              swipePositionLast = details.globalPosition.dy;
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 20),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green,
                child: Icon(Icons.category, size: 45),
              ),
            ),
          ));

          if (vm.categoryLoading) {
            col.add(
              const ListTile(
                title: Text('Loading...'),
              ),
            );
          } else {
            col.add(
              ListTile(
                title: Text('ALL ${vm.categories.category.length}'),
                selected: vm.categorySelected == '',
                onTap: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(ActionShopCategoryChoose(category: ''));
                  StoreProvider.of<AppState>(context)
                      .dispatch(ActionShopCatalogClear());
                  StoreProvider.of<AppState>(context)
                      .dispatch(ActionShopCatalogLoadMore(category: ''));
                  StoreProvider.of<AppState>(context)
                      .dispatch(ActionUiSelectCategory(open: false));
                },
              ),
            );

            for (final cat in vm.categories.category) {
              col.add(ListTile(
                title: Text(cat.toUpperCase()),
                selected: vm.categorySelected == cat,
                onTap: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(ActionShopCategoryChoose(category: cat));
                  StoreProvider.of<AppState>(context)
                      .dispatch(ActionShopCatalogClear());
                  StoreProvider.of<AppState>(context)
                      .dispatch(ActionShopCatalogLoadMore(category: cat));
                  StoreProvider.of<AppState>(context)
                      .dispatch(ActionUiSelectCategory(open: false));
                },
              ));
            }
          }

          return Drawer(
              child: SingleChildScrollView(child: Column(children: col)));
        });
  }
}

@freezed
class _ViewModel with _$_ViewModel {
  const factory _ViewModel({
    required String categorySelected,
    required bool categoryLoading,
    required CategoriesListModel categories,
  }) = __ViewModel;

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        categoryLoading: store.state.categoryLoading,
        categorySelected: store.state.categorySelected,
        categories: store.state.categories,
      );
}
