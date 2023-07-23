import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/business/state_manager.dart';

//ignore: must_be_immutable
class CategorySelectorLeftDrawer extends StatelessWidget {
  CategorySelectorLeftDrawer({super.key});

  double swipePositionStart = 0;
  double swipePositionLast = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Consumer<StateManager>(
          builder: (context, stateManager, child) {
            List<Widget> col = [];
            col.addAll([
              GestureDetector(
                onPanEnd: (details) {
                  // swipe down reloads categories
                  if (swipePositionStart - swipePositionLast < 0) {
                    // print('swipe down');
                    stateManager.getCategories();
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
                title: Text('ALL ${stateManager.categoriesNum}'),
                selected: stateManager.categoryActive == '',
                onTap: () {
                  stateManager.categoryActive = '';
                  stateManager.getCatalog(category: '');
                  Navigator.of(context).pop();
                },
              ),
            ]);

            // int n = 0;
            for (final cat in stateManager.categories) {
              // in-loop var nn to avoid Dart optimization
              // var nn = n;
              col.add(ListTile(
                title: Text(cat.toUpperCase()),
                selected: stateManager.categoryActive == cat,
                onTap: () {
                  stateManager.categoryActive = cat;
                  stateManager.getCatalog(category: cat);
                  // close drawer
                  Navigator.of(context).pop();
                },
              ));
              // n++;
            }

            return Column(
              children: col,
            );
          },
        ),
      ),
    );
  }
}
