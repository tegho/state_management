import '/business/states/app_state.dart';
import '/business/actions/ui_actions.dart';

AppState onActionUiInit(AppState state, ActionUiInit action) {
  // Feature: open cart by default
  // return state.copyWith(drawerOpened: DrawersState.cart);
  return state.copyWith(
    lastAction: action,
  );
}

AppState onActionUiSelectCategory(
    AppState state, ActionUiSelectCategory action) {
  return state.copyWith(
    lastAction: action,
    drawerOpened: (action.open) ? DrawersState.category : DrawersState.none,
  );
}

AppState onActionUiShowCart(AppState state, ActionUiShowCart action) {
  return state.copyWith(
    lastAction: action,
    drawerOpened: (action.open) ? DrawersState.cart : DrawersState.none,
  );
}

AppState onActionUiShowProduct(AppState state, ActionUiShowProduct action) {
  return state.copyWith(
    lastAction: action,
    uiProductPage: action.product,
  );
}
