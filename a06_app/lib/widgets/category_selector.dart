import 'package:flutter/material.dart';

import '/business/business_provider.dart';

class CategorySelectorLeftDrawer extends StatelessWidget {
  final BusinessProvider businessProvider;

  const CategorySelectorLeftDrawer({super.key, required this.businessProvider});

  @override
  Widget build(BuildContext context) {
    double swipePositionStart = 0;
    double swipePositionLast = 0;

    businessProvider.categoriesBloc.action.add(ActionCategoriesPullState());
    return StreamBuilder<CategoriesState>(
        stream: businessProvider.categoriesBloc.state,
        builder: (context, snapshot) {
          List<Widget> col = [];
          col.add(GestureDetector(
            onPanEnd: (details) {
              // swipe down reloads categories
              if (swipePositionStart - swipePositionLast < 0) {
                // print('swipe down');
                businessProvider.categoriesBloc.action
                    .add(ActionCategoriesClear());
                businessProvider.categoriesBloc.action
                    .add(ActionCategoriesLoad());
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

          if ((!snapshot.hasData) ||
              ((snapshot.hasData) && (snapshot.data!.list.category.isEmpty))) {
            col.add(
              const ListTile(
                title: Text('Loading...'),
              ),
            );
          } else {
            col.add(
              ListTile(
                title: Text('ALL ${snapshot.data!.list.category.length}'),
                selected: snapshot.data!.selected == '',
                onTap: () {
                  businessProvider.categoriesBloc.action
                      .add(ActionCategoriesChoose(category: ''));
                  businessProvider.catalogBloc.action.add(ActionCatalogClear());
                  businessProvider.catalogBloc.action
                      .add(ActionCatalogLoadMore(category: ''));
                  businessProvider.uiBloc.action
                      .add(ActionUiSelectCategory(open: false));
                },
              ),
            );

            for (final cat in snapshot.data!.list.category) {
              col.add(ListTile(
                title: Text(cat.toUpperCase()),
                selected: snapshot.data!.selected == cat,
                onTap: () {
                  businessProvider.categoriesBloc.action
                      .add(ActionCategoriesChoose(category: cat));
                  businessProvider.catalogBloc.action.add(ActionCatalogClear());
                  businessProvider.catalogBloc.action
                      .add(ActionCatalogLoadMore(category: cat));
                  businessProvider.uiBloc.action
                      .add(ActionUiSelectCategory(open: false));
                },
              ));
            }
          }

          return Drawer(
              child: SingleChildScrollView(child: Column(children: col)));
        });
  }
}
