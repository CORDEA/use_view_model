import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:use_view_model/use_view_model.dart';

import 'details.dart';
import 'home_view_model.dart';

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = useViewModel(builder: () => HomeViewModel());
    return Scaffold(
      appBar: AppBar(title: Text(useValueListenable(viewModel.title))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _HomeBody(),
      ),
    );
  }
}

class _HomeBody extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Label(),
        const SizedBox(height: 32),
        _Button(),
        const SizedBox(height: 64),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const Details()),
            );
          },
          child: const Text('Details'),
        ),
      ],
    );
  }
}

class _Label extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useViewModel<HomeViewModel>();
    return Text(
      useValueListenable(viewModel.count),
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

class _Button extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useViewModel<HomeViewModel>();
    return ElevatedButton(
      onPressed: viewModel.onTapped,
      child: const Text('Add'),
    );
  }
}
