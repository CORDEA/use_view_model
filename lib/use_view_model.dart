library use_view_model;

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

T useViewModel<T extends ViewModel>() => use(_ViewModelHook());

abstract class ViewModel {
  void dispose();
}

class ViewModelScope<T extends ViewModel> extends InheritedWidget {
  const ViewModelScope({
    super.key,
    required this.viewModel,
    required super.child,
  });

  static T of<T extends ViewModel>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ViewModelScope<T>>()!
        .viewModel;
  }

  final T viewModel;

  @override
  InheritedElement createElement() => _ViewModelScope(this);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is! ViewModelScope || oldWidget.viewModel != viewModel;
  }
}

class _ViewModelScope extends InheritedElement {
  _ViewModelScope(super.widget);

  @override
  void unmount() {
    (widget as ViewModelScope).viewModel.dispose();
    super.unmount();
  }
}

class _ViewModelHook<T extends ViewModel> extends Hook<T> {
  @override
  HookState<T, Hook<T>> createState() => _ViewModelHookState();
}

class _ViewModelHookState<T extends ViewModel>
    extends HookState<T, _ViewModelHook<T>> {
  @override
  build(BuildContext context) => ViewModelScope.of<T>(context);
}
