import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:use_view_model/use_view_model.dart';

class DetailsViewModel extends ViewModel {
  StreamSubscription? _subscription;

  ValueListenable<String> get label => _label;
  final _label = ValueNotifier('Ready');

  Future<void> onTapped() async {
    _subscription = Stream.periodic(
      const Duration(seconds: 1),
      (c) => c.toString(),
    ).listen(
      (v) {
        if (kDebugMode) {
          print('count: $v');
        }
        _label.value = v;
      },
    );
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('cancel');
    }
    _subscription?.cancel();
    _label.dispose();
  }
}
