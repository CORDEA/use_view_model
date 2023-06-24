import 'package:flutter/foundation.dart';
import 'package:use_view_model/use_view_model.dart';

class HomeViewModel extends ViewModel {
  var _rawCount = 0;

  ValueListenable<String> get title => _title;
  final _title = ValueNotifier('Title');

  ValueListenable<String> get count => _count;
  final _count = ValueNotifier('0');

  void onTapped() {
    _rawCount++;
    _count.value = _rawCount.toString();
    _title.value = 'Title: ${_count.value}';
  }

  @override
  void dispose() {
    _title.dispose();
    _count.dispose();
  }
}
