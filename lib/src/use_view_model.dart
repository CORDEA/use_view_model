import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'view_model.dart';
import 'view_model_store.dart';
import 'view_model_store_owner.dart';

T useViewModel<T extends ViewModel>({
  ValueGetter<T>? builder,
  Key? key,
}) =>
    use(_ViewModelHook(key ?? ValueKey(T), builder));

class _ViewModelHook<T extends ViewModel> extends Hook<T> {
  const _ViewModelHook(this.key, this.builder);

  final Key key;
  final ValueGetter<T>? builder;

  @override
  HookState<T, Hook<T>> createState() => _ViewModelHookState();
}

class _ViewModelHookState<T extends ViewModel>
    extends HookState<T, _ViewModelHook<T>> {
  late final viewModel = hook.builder?.call();
  late final isParent = hook.builder != null;
  late ViewModelStore store;

  @override
  build(BuildContext context) {
    store = ViewModelStoreOwner.of(context);
    final viewModel = this.viewModel;
    if (viewModel != null) {
      store.put(hook.key, viewModel);
      return viewModel;
    }
    return store.get(hook.key) as T;
  }

  @override
  void dispose() {
    if (isParent) {
      store.remove(hook.key);
    }
    super.dispose();
  }
}
