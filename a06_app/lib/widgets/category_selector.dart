import 'package:flutter/material.dart';

import '/business/blocs/ui_bloc.dart';
import '/business/actions/categories_actions.dart';
import '/business/actions/catalog_actions.dart';
import '/business/actions/ui_actions.dart';
import '/business/states/categories_state.dart';

class CategorySelectorLeftDrawer extends StatelessWidget {
  final UiBloc uiBloc;

  const CategorySelectorLeftDrawer({super.key, required this.uiBloc});

  @override
  Widget build(BuildContext context) {
    double swipePositionStart = 0;
    double swipePositionLast = 0;

    uiBloc.categoriesBloc.action.add(ActionCategoriesPullState());
    return StreamBuilder<CategoriesState>(
        stream: uiBloc.categoriesBloc.state,
        builder: (context, snapshot) {
          List<Widget> col = [];
          col.add(GestureDetector(
            onPanEnd: (details) {
              // swipe down reloads categories
              if (swipePositionStart - swipePositionLast < 0) {
                // print('swipe down');
                uiBloc.categoriesBloc.action.add(ActionCategoriesClear());
                uiBloc.categoriesBloc.action.add(ActionCategoriesLoad());
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
                  uiBloc.categoriesBloc.action
                      .add(ActionCategoriesChoose(category: ''));
                  uiBloc.catalogBloc.action.add(ActionCatalogClear());
                  uiBloc.catalogBloc.action
                      .add(ActionCatalogLoadMore(category: ''));
                  uiBloc.action.add(ActionUiSelectCategory(open: false));
                },
              ),
            );

            for (final cat in snapshot.data!.list.category) {
              col.add(ListTile(
                title: Text(cat.toUpperCase()),
                selected: snapshot.data!.selected == cat,
                onTap: () {
                  uiBloc.categoriesBloc.action
                      .add(ActionCategoriesChoose(category: cat));
                  uiBloc.catalogBloc.action.add(ActionCatalogClear());
                  uiBloc.catalogBloc.action
                      .add(ActionCatalogLoadMore(category: cat));
                  uiBloc.action.add(ActionUiSelectCategory(open: false));
                },
              ));
            }
          }

          return Drawer(
              child: SingleChildScrollView(child: Column(children: col)));
        });
  }
}
