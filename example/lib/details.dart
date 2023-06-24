import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:use_view_model/use_view_model.dart';

import 'details_view_model.dart';

class Details extends HookWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = useViewModel(builder: () => DetailsViewModel());
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ElevatedButton(
            onPressed: viewModel.onTapped,
            child: Text(useValueListenable(viewModel.label)),
          ),
        ),
      ),
    );
  }
}
