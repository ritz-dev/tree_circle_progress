# Tree Circle Progress Example

This example demonstrates how to use the `tree_circle_progress` package with a sample asset package.

## Setup

1. Make sure you have Flutter installed
2. Navigate to the example directory:
   ```bash
   cd example
   ```

3. Get dependencies:
   ```bash
   flutter pub get
   ```

4. Run the example:
   ```bash
   flutter run
   ```

## What This Example Shows

- How to use `TreeCirclePointProgressCard` with `assetPackage`
- Interactive tree planting simulation
- Proper asset package setup
- Error handling for missing assets

## Asset Package Structure

The example includes a sample `tree_assets` package that provides the tree images:

```
example/
├── packages/
│   └── tree_assets/
│       ├── pubspec.yaml
│       └── assets/
│           └── logo/
│               ├── tree_0.png
│               ├── tree_1.png
│               └── ... (up to tree_19.png)
```

## Usage in Your App

To use this in your own app:

1. Create a package for your assets (or use an existing one)
2. Declare the tree images in the package's `pubspec.yaml`
3. Add the package as a dependency in your app
4. Use the widget with `assetPackage` parameter

```dart
TreeCirclePointProgressCard(
  treesPlanted: 10,
  pointsRemaining: 50,
  assetPackage: 'your_asset_package_name',
)
```