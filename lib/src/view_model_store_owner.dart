import 'package:flutter/material.dart';
import 'package:use_view_model/src/view_model_store.dart';

class ViewModelStoreOwner extends InheritedWidget {
  const ViewModelStoreOwner({
    super.key,
    required super.child,
    required this.viewModelStore,
  });

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
