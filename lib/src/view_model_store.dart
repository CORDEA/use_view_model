import 'package:flutter/foundation.dart';
import 'package:use_view_model/use_view_model.dart';

class ViewModelStore {
  static final defaultInstance = ViewModelStore();

  final _map = <Key, ViewModel>{};

  void put(Key key, ViewModel viewModel) {
    _map.remove(key)?.dispose();
    _map[key] = viewModel;
  }

  ViewModel? get(Key key) => _map[key];

  void remove(Key key) => _map.remove(key)?.dispose();

  void clear() {
    for (final viewModel in _map.values) {
      viewModel.dispose();
    }
    _map.clear();
  }

  @override
  int get hashCode => _map.hashCode;

  @override
  bool operator ==(Object other) {
    return other is ViewModelStore && mapEquals(other._map, _map);
  }
}
