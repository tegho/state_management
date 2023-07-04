import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'business/state_manager.dart';
import 'widgets/cart_drawer.dart';
import 'widgets/main_page.dart';
import 'widgets/category_selector.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StateManager>(
      create: (_) => StateManager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title:
                Consumer<StateManager>(builder: (context, stateManager, child) {
              return Text((stateManager.categoryActive.isEmpty)
                  ? 'ALL'
                  : stateManager.categoryActive.toUpperCase());
            }),
            actions: [
              Consumer<StateManager>(builder: (context, stateManager, child) {
                return SizedBox(
                  width: 84,
                  child: FilledButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(stateManager.cart.items.length.toString(),
                              style: const TextStyle(color: Colors.black)),
                          const Icon(Icons.shopping_cart),
                        ],
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      }),
                );
              }),
            ],
          ),
          drawer: CategorySelectorLeftDrawer(),
          endDrawer: const CartDrawer(),
          body: const SafeArea(child: MainPage()),
        ),
      ),
    );
  }
}
