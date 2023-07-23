import 'package:flutter/material.dart';

import '/business/business_provider.dart';

class CategorySelectorLeftDrawer extends StatelessWidget {
  const CategorySelectorLeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double swipePositionStart = 0;
    double swipePositionLast = 0;

    context.read<CategoriesBloc>().add(ActionCategoriesPullState());
    return BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, snapshot) {
      List<Widget> col = [];
      col.add(GestureDetector(
        onPanEnd: (details) {
          // swipe down reloads categories
          if (swipePositionStart - swipePositionLast < 0) {
            // print('swipe down');
            context.read<CategoriesBloc>().add(ActionCategoriesClear());
            context.read<CategoriesBloc>().add(ActionCategoriesLoad());
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

      if (snapshot.list.category.isEmpty) {
        col.add(
          const ListTile(
            title: Text('Loading...'),
          ),
        );
      } else {
        col.add(
          ListTile(
            title: Text('ALL ${snapshot.list.category.length}'),
            selected: snapshot.selected == '',
            onTap: () {
              context
                  .read<CategoriesBloc>()
                  .add(ActionCategoriesChoose(category: ''));
              context.read<CatalogBloc>().add(ActionCatalogClear());
              context
                  .read<CatalogBloc>()
                  .add(ActionCatalogLoadMore(category: ''));
              context.read<UiBloc>().add(ActionUiSelectCategory(open: false));
            },
          ),
        );

        for (final cat in snapshot.list.category) {
          col.add(ListTile(
            title: Text(cat.toUpperCase()),
            selected: snapshot.selected == cat,
            onTap: () {
              context
                  .read<CategoriesBloc>()
                  .add(ActionCategoriesChoose(category: cat));
              context.read<CatalogBloc>().add(ActionCatalogClear());
              context
                  .read<CatalogBloc>()
                  .add(ActionCatalogLoadMore(category: cat));
              context.read<UiBloc>().add(ActionUiSelectCategory(open: false));
            },
          ));
        }
      }

      return Drawer(child: SingleChildScrollView(child: Column(children: col)));
    });
  }
}
