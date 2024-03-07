import 'package:flutter/material.dart';

class ReposScreen extends StatelessWidget {
  const ReposScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Repos screen'),
        ),
        body: const Center(child: Text('Repos list')),
      );
}
