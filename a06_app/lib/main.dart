import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:shopdata/shopdata.dart';

import '/business/blocs/categories_bloc.dart';
import '/business/blocs/catalog_bloc.dart';
import '/business/blocs/cart_bloc.dart';
import '/business/blocs/ui_bloc.dart';
import '/business/actions/categories_actions.dart';
import '/business/actions/catalog_actions.dart';
import '/business/actions/cart_actions.dart';
import '/business/actions/ui_actions.dart';
import '/business/states/categories_state.dart';
import '/business/states/cart_state.dart';
import '/business/states/ui_state.dart';

import '/widgets/cart_drawer.dart';
import '/widgets/category_selector.dart';
import '/widgets/main_page.dart';

void main() {
  serviceProviderInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final DataService dataService;
    final CategoriesBloc categoriesBloc;
    final CatalogBloc catalogBloc;
    final CartBloc cartBloc;
    final UiBloc uiBloc;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    void handleDrawers(UiState state) {
      switch (state.drawerOpened) {
        case DrawersState.category:
          scaffoldKey.currentState!.closeEndDrawer();
          scaffoldKey.currentState!.openDrawer();
          break;
        case DrawersState.cart:
          scaffoldKey.currentState!.closeDrawer();
          scaffoldKey.currentState!.openEndDrawer();
          break;
        case DrawersState.none:
          scaffoldKey.currentState!.closeDrawer();
          scaffoldKey.currentState!.closeEndDrawer();
          break;
        default:
          throw UnimplementedError('Unknown drawer state');
      }
    }

    dataService = GetIt.I.get<DataService>();

    cartBloc = CartBloc();
    categoriesBloc = CategoriesBloc(dataService);
    catalogBloc = CatalogBloc(dataService);
    uiBloc = UiBloc(categoriesBloc, catalogBloc, cartBloc);

    categoriesBloc.action.add(ActionCategoriesInit());
    catalogBloc.action.add(ActionCatalogInit());
    cartBloc.action.add(ActionCartInit());
    uiBloc.action.add(ActionUiInit());

    uiBloc.state.listen(handleDrawers);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: FilledButton(
              child: const Icon(Icons.category),
              onPressed: () {
                uiBloc.action.add(ActionUiSelectCategory(open: true));
              }),
          title: StreamBuilder<CategoriesState>(
            stream: uiBloc.categoriesBloc.state,
            builder: (context, snapshot) {
              if ((!snapshot.hasData) ||
                  ((snapshot.hasData) &&
                      (snapshot.data!.list.category.isEmpty))) {
                return const Text('Loading...');
              } else {
                return Text((snapshot.data!.selected.isEmpty)
                    ? 'ALL'
                    : snapshot.data!.selected.toUpperCase());
              }
            },
          ),
          actions: [
            StreamBuilder<CartState>(
              stream: uiBloc.cartBloc.state,
              builder: (context, snapshot) {
                int cartNum = 0;

                if (snapshot.hasData) {
                  cartNum = snapshot.data!.list.length;
                }

                return SizedBox(
                  width: 84,
                  child: FilledButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(cartNum.toString(),
                              style: const TextStyle(color: Colors.black)),
                          const Icon(Icons.shopping_cart),
                        ],
                      ),
                      onPressed: () {
                        uiBloc.action.add(ActionUiShowCart(open: true));
                      }),
                );
              },
            ),
          ],
        ),
        drawer: CategorySelectorLeftDrawer(uiBloc: uiBloc),
        onDrawerChanged: (isOpened) {
          if (!isOpened) {
            uiBloc.action.add(ActionUiSelectCategory(open: false));
          }
        },
        endDrawer: CartDrawer(uiBloc: uiBloc),
        onEndDrawerChanged: (isOpened) {
          if (!isOpened) {
            uiBloc.action.add(ActionUiShowCart(open: false));
          }
        },
        body: SafeArea(child: MainPage(uiBloc: uiBloc)),
      ),
    );
  }
}
