import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '/business/business_provider.dart';

part 'catalog_title.freezed.dart';

class CatalogTitle extends StatelessWidget {
  const CatalogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        if (vm.categoryLoading) {
          return const Text('Loading...');
        } else {
          return Text((vm.categorySelected.isEmpty)
              ? 'ALL'
              : vm.categorySelected.toUpperCase());
        }
      },
    );
  }
}

@freezed
class _ViewModel with _$_ViewModel {
  const factory _ViewModel({
    required String categorySelected,
    required bool categoryLoading,
  }) = __ViewModel;

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        categoryLoading: store.state.categoryLoading,
        categorySelected: store.state.categorySelected,
      );
}
