import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '/business/business_provider.dart';

class CategorySelectorLeftDrawer extends StatelessWidget {
  const CategorySelectorLeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double swipePositionStart = 0;
    double swipePositionLast = 0;

    final appState = Provider.of<AppState>(context);

    return Observer(builder: (context) {
      List<Widget> col = [];
      col.add(GestureDetector(
        onPanEnd: (details) {
          // swipe down reloads categories
          if (swipePositionStart - swipePositionLast < 0) {
            // print('swipe down');
            appState.actionShopCategoriesReload();
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

      if (appState.categoryLoading) {
        col.add(
          const ListTile(
            title: Text('Loading...'),
          ),
        );
      } else {
        col.add(
          ListTile(
            title: Text('ALL ${appState.categories.category.length}'),
            selected: appState.categorySelected == '',
            onTap: () {
              appState.actionShopCategoryChoose(category: '');
              appState.actionShopCatalogClear();
              appState.actionShopCatalogLoadMore(category: '');
              appState.actionUiSelectCategory(open: false);
            },
          ),
        );

        for (final cat in appState.categories.category) {
          col.add(ListTile(
            title: Text(cat.toUpperCase()),
            selected: appState.categorySelected == cat,
            onTap: () {
              appState.actionShopCategoryChoose(category: cat);
              appState.actionShopCatalogClear();
              appState.actionShopCatalogLoadMore(category: cat);
              appState.actionUiSelectCategory(open: false);
            },
          ));
        }
      }

      return Drawer(child: SingleChildScrollView(child: Column(children: col)));
    });
  }
}
