# tree_circle_progress

A Flutter package to display tree planting progress in a circular style.

## Getting Started

This package provides a reusable `TreeProgressCard` widget that shows the percentage of trees planted with a circular progress indicator and a tree image animation.

### Example Usage

```dart
import 'package:flutter/material.dart';
import 'package:tree_circle_progress/tree_circle_progress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Tree Progress Example')),
        body: const Center(
          child: TreeProgressCard(),
        ),
      ),
    );
  }
}
