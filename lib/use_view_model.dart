library use_view_model;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:use_view_model/src/view_model_store_owner.dart';

T useViewModel<T extends ViewModel>({
  T? viewModel,
  Key? key,
}) =>
    use(_ViewModelHook(key ?? ValueKey(T), viewModel));

abstract class ViewModel {
  void dispose();
}

class _ViewModelHook<T extends ViewModel> extends Hook<T> {
  const _ViewModelHook(this.key, this.viewModel);

  final Key key;
  final T? viewModel;

  @override
  HookState<T, Hook<T>> createState() => _ViewModelHookState();
}

class _ViewModelHookState<T extends ViewModel>
    extends HookState<T, _ViewModelHook<T>> {
  late final isParent = hook.viewModel != null;

  @override
  build(BuildContext context) {
    final owner = ViewModelStoreOwner.of(context);
    final viewModel = hook.viewModel;
    if (viewModel != null) {
      owner.put(hook.key, viewModel);
      return viewModel;
    }
    return owner.get(hook.key) as T;
  }

  @override
  void dispose() {
    if (isParent) {
      ViewModelStoreOwner.of(context).remove(hook.key);
    }
    super.dispose();
  }
}
