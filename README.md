# tree_circle_progress

A Flutter package to display tree planting progress in a circular style with animated tree images.

## Overview

The `TreeCirclePointProgressCard` widget provides a visual representation of tree planting progress. It features:
- A circular progress indicator that animates automatically.
- A central tree image that changes based on progress (from seedling to full tree), loaded from a specified asset package.
- Play/pause controls for the animation.
- Display of planted trees and remaining points.

## Tree Image View

The tree image view is the core visual element that animates based on the progress value. It displays different tree growth stages as the progress increases from 0% to 100%.

### How It Works
- Progress ranges from 0.0 to 1.0 (0% to 100%).
- The `getTreeImage` function maps progress to an index (0-20), selecting the appropriate tree image asset.
- Images are loaded from `assets/logo/tree_<index>.png` (e.g., `tree_0.png` for 0-4%, `tree_1.png` for 5-9%, up to `tree_20.png` for 100%).

### Asset Requirements
- Provide 21 tree images: `tree_0.png` through `tree_20.png` in your `assets/logo/` directory.
- Declare assets in your `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/logo/tree_0.png
    - assets/logo/tree_1.png
    - assets/logo/tree_2.png
    # ... list all 21 images
    - assets/logo/tree_20.png
```

### Loading from a Mini Package
Tree images are loaded from a specified asset package using the `assetPackage` parameter. This is required for images to display.

```dart
TreeCirclePointProgressCard(
  treesPlanted: 5,
  pointsRemaining: 100,
  assetPackage: 'my_tree_assets_package',
)
```

Ensure the package:
- Is added as a dependency in your app's `pubspec.yaml`.
- Declares the assets under `flutter/assets` with the same relative paths.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `treesPlanted` | `int` | Yes | Number of trees planted, displayed as text. |
| `pointsRemaining` | `int` | Yes | Points needed for the next tree, displayed as "+X points more". |
| `assetPackage` | `String` | Yes | Package name to load tree images from. Required for images to display. |
| `key` | `Key?` | No | Standard Flutter key parameter. |

## Usage Examples

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:tree_circle_progress/tree_circle_progress.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TreeCirclePointProgressCard(
      treesPlanted: 10,
      pointsRemaining: 50,
      assetPackage: 'tree_assets',
    );
  }
}
```

### With Custom Asset Package

```dart
TreeCirclePointProgressCard(
  treesPlanted: 15,
  pointsRemaining: 25,
  assetPackage: 'custom_tree_assets',
)
```

### In a Stateful Widget for Dynamic Updates

```dart
class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int trees = 0;
  int points = 100;

  void updateProgress() {
    setState(() {
      trees += 1;
      points = 100 - (trees % 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TreeCirclePointProgressCard(
          treesPlanted: trees,
          pointsRemaining: points,
          assetPackage: 'tree_assets',
        ),
        ElevatedButton(
          onPressed: updateProgress,
          child: Text('Plant Tree'),
        ),
      ],
    );
  }
}
```

## API Reference

### TreeCirclePointProgressCard

A stateful widget that displays the progress card.

#### Methods
- `getTreeImage(double progress)`: Returns the asset path for the tree image based on progress.

#### State Management
- Automatically starts progress animation on init.
- Tap the center circle to play/pause animation.
- Animation loops every 800ms, incrementing progress by 1%.

## Troubleshooting

### Tree Images Not Showing
- **Provide assetPackage**: The `assetPackage` parameter is required for images to display.
- **Check Console**: Look for "Failed to load asset" messages in debug console.
- **Verify Assets**: Ensure all 21 tree images are present in the package's `assets/logo/` and declared in the package's `pubspec.yaml`.
- **Asset Package**: Confirm the package name is correct and the package is added as a dependency in your app's `pubspec.yaml`.
- **Path Format**: Asset paths must be `assets/logo/tree_<index>.png` (no variations).

### Animation Not Working
- Ensure the widget is in a stateful context.
- Check for timer conflicts if multiple instances exist.

### Error Handling
The widget includes built-in error handling:
- Failed image loads show a broken image icon.
- Debug messages print to console with asset path and error details.

## Contributing

Contributions are welcome! Please ensure:
- Assets follow the naming convention.
- Code includes appropriate error handling.
- Documentation is updated for API changes.

## License

This package is licensed under the MIT License. See LICENSE file for details.
