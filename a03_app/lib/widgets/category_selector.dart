import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/business/providers.dart';

//ignore: must_be_immutable
class CategorySelectorLeftDrawer extends ConsumerWidget {
  CategorySelectorLeftDrawer({super.key});

  double swipePositionStart = 0;
  double swipePositionLast = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    List<Widget> col = [];
    col.addAll([
      GestureDetector(
        onPanEnd: (details) {
          // swipe down reloads categories
          if (swipePositionStart - swipePositionLast < 0) {
            // print('swipe down');
            ref.read(categoriesProvider.notifier).getCategories();
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
      ),
      ListTile(
        title: Text('ALL ${categories.length.toString()}'),
        selected: ref.read(activeCategoryProvider.notifier).state == '',
        onTap: () {
          ref.read(activeCategoryProvider.notifier).state = '';
          ref.read(catalogProvider.notifier).clear();
          ref.read(catalogProvider.notifier).getCatalog(category: '');
          Navigator.of(context).pop();
        },
      ),
    ]);
    for (final cat in categories) {
      col.add(ListTile(
        title: Text(cat.toUpperCase()),
        selected: ref.read(activeCategoryProvider.notifier).state == cat,
        onTap: () {
          ref.read(activeCategoryProvider.notifier).state = cat;
          ref.read(catalogProvider.notifier).clear();
          ref.read(catalogProvider.notifier).getCatalog(category: cat);
          Navigator.of(context).pop();
        },
      ));
    }

    return Drawer(child: SingleChildScrollView(child: Column(children: col)));
  }
}
