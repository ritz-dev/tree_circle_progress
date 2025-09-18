import 'package:flutter/material.dart';
import 'package:tree_circle_progress/tree_circle_point_progress_card.dart';

void main() {
  runApp(const TreeProgressExampleApp());
}

class TreeProgressExampleApp extends StatelessWidget {
  const TreeProgressExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Circle Progress Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int treesPlanted = 5;
  int pointsRemaining = 95;

  void _plantTree() {
    setState(() {
      treesPlanted++;
      pointsRemaining = 100 - (treesPlanted % 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tree Progress Example'),
        backgroundColor: const Color(0xFF0A4DA2),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TreeCirclePointProgressCard(
                treesPlanted: treesPlanted,
                pointsRemaining: pointsRemaining,
                assetPackage: 'tree_assets',
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _plantTree,
                icon: const Icon(Icons.nature),
                label: const Text('Plant a Tree'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3FA9F5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Trees Planted: $treesPlanted\nPoints to Next: $pointsRemaining',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
