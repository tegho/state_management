import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobx/mobx.dart';

import '/business/business_provider.dart';

import '/widgets/product_info.dart';
import '/widgets/catalog_title.dart';
import '/widgets/cart_action_button.dart';
import '/widgets/category_selector.dart';
import '/widgets/cart_drawer.dart';
import '/widgets/catalog_viewer.dart';

//ignore: must_be_immutable
class MainPage extends StatelessWidget {
  MainPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer? reactionDisposerInfoPage;
  ReactionDisposer? reactionDisposerDrawers;

  @override
  Widget build(BuildContext context) {
    // if this page is already built and alive
    bool isThisPageGood() {
      return (scaffoldKey.currentState == null) ? false : true;
    }

    final appState = Provider.of<AppState>(context);

    // this page has been rebuilt, resized, etc
    if (reactionDisposerDrawers != null) {
      reactionDisposerDrawers!();
    }
    if (reactionDisposerInfoPage != null) {
      reactionDisposerInfoPage!();
    }

    // reaction on drawers UI events
    reactionDisposerDrawers = autorun((_) {
      final drawerOpened = appState.drawerOpened;

      if (!isThisPageGood()) {
        if (reactionDisposerDrawers != null) {
          reactionDisposerDrawers!();
        }
        return;
      }

      switch (drawerOpened) {
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
    });

    // reaction on open info page events
    reactionDisposerInfoPage = autorun((_) {
      final uiProductPage = appState.uiProductPage;

      if (!isThisPageGood()) {
        if (reactionDisposerInfoPage != null) {
          reactionDisposerInfoPage!();
        }
        return;
      }

      if (uiProductPage != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            maintainState: false,
            builder: (context) => ProductInfo(
              product: uiProductPage,
            ),
          ),
        );
      }
      // }
    });

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: FilledButton(
            child: const Icon(Icons.category),
            onPressed: () {
              appState.actionUiSelectCategory(open: true);
            }),
        title: const CatalogTitle(),
        actions: const [
          SizedBox(
            width: 84,
            child: CartActionButton(),
          ),
        ],
      ),
      drawer: const CategorySelectorLeftDrawer(),
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          appState.actionUiSelectCategory(open: false);
        }
      },
      endDrawer: const CartDrawer(),
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          appState.actionUiShowCart(open: false);
        }
      },
      body: SafeArea(
        child: CatalogViewer(),
      ),
    );
  }
}
