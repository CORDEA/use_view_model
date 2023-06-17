import 'package:flutter/material.dart';

import 'view_model_store.dart';

class ViewModelStoreOwner extends InheritedWidget {
  ViewModelStoreOwner({
    super.key,
    required super.child,
  }) : viewModelStore = ViewModelStore();

  final ViewModelStore viewModelStore;

  static ViewModelStore of(BuildContext context) {
    final owner =
        context.dependOnInheritedWidgetOfExactType<ViewModelStoreOwner>();
    return owner?.viewModelStore ?? ViewModelStore.defaultInstance;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is! ViewModelStoreOwner ||
        oldWidget.viewModelStore != viewModelStore;
  }
}
