import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'business/providers.dart';
import 'widgets/cart_drawer.dart';
import 'widgets/category_selector.dart';
import 'widgets/main_page.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Consumer(
            builder: (context, ref, _) {
              final activeCategory = ref.watch(activeCategoryProvider);

              return Text((activeCategory.isEmpty)
                  ? 'ALL'
                  : activeCategory.toUpperCase());
            },
          ),
          actions: [
            Consumer(
              builder: (context, ref, _) {
                final cart = ref.watch(cartProvider);

                return SizedBox(
                  width: 84,
                  child: FilledButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(cart.length.toString(),
                              style: const TextStyle(color: Colors.black)),
                          const Icon(Icons.shopping_cart),
                        ],
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      }),
                );
              },
            ),
          ],
        ),
        drawer: CategorySelectorLeftDrawer(),
        endDrawer: const CartDrawer(),
        body: const SafeArea(child: MainPage()),
      ),
    );
  }
}
