import 'package:flutter/material.dart';
import 'package:tree_circle_progress/tree_circle_point_progress_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Circle Progress',
      debugShowCheckedModeBanner: false,
      home: TreeCirclePointProgressCard(),
    );
  }
}
