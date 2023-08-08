import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '/business/business_provider.dart';

class CatalogTitle extends StatelessWidget {
  const CatalogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Observer(
      builder: (context) {
        if (appState.categoryLoading) {
          return const Text('Loading...');
        } else {
          return Text((appState.categorySelected.isEmpty)
              ? 'ALL'
              : appState.categorySelected.toUpperCase());
        }
      },
    );
  }
}
