import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TreeCirclePointProgressCard extends StatefulWidget {
  final int treesPlanted;
  final int pointsRemaining;
  final String? assetPackage;

  const TreeCirclePointProgressCard({
    super.key,
    required this.treesPlanted,
    required this.pointsRemaining,
    this.assetPackage,
  });

  @override
  State<TreeCirclePointProgressCard> createState() =>
      _TreeCirclePointProgressCardState();
}

class _TreeCirclePointProgressCardState
    extends State<TreeCirclePointProgressCard> {
  double progress = 0.0; // 0.0–1.0
  Timer? _timer;
  bool isPlaying = true; // Track play/pause
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();
    _preloadImages();
    _startAutoProgress();
  }

  void _preloadImages() {
    // Preload all tree images for better performance (0-19 = 20 images total)
    _imagePaths = List.generate(20, (index) => "assets/logo/tree_$index.png");

    // Preload images in the background
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (String imagePath in _imagePaths) {
        precacheImage(
          AssetImage(imagePath, package: widget.assetPackage),
          context,
        );
      }
    });
  }

  void _startAutoProgress() {
    _timer?.cancel(); // cancel any existing timer
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        progress += 0.001; // increment 0.1%
        if (progress > 1.0) progress = 0.0; // loop back to 0
      });
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _timer?.cancel(); // stop timer
        isPlaying = false;
      } else {
        isPlaying = true;
        _startAutoProgress(); // restart timer
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Developer note:
  // - `assetPackage` (optional) can be provided to load images from another
  //   package (a mini package). If null, images are loaded from the app's
  //   asset bundle.
  // - Keep the asset path format `assets/logo/tree_<index>.png` and ensure
  //   the package that provides the assets declares them under
  //   `flutter/assets` in its `pubspec.yaml` and is added as a dependency.
  String getTreeImage(double progress) {
    int percent = (progress * 100).round();
    int index = (percent / 5).floor(); // 0–19 (20 images total)
    if (index > 19) index = 19; // Clamp to maximum available image
    if (index < _imagePaths.length) {
      return _imagePaths[index];
    }
    return "assets/logo/tree_$index.png";
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).round();

    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 180,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Grey background circle
                CustomPaint(
                  size: const Size(160, 160),
                  painter: _CirclePainter(
                    progress: 1,
                    strokeWidth: 14,
                    gradient: const SweepGradient(
                      colors: [Color(0xffE6E5E5), Color(0xffE6E5E5)],
                    ),
                    isBackground: true,
                  ),
                ),

                // Progress arc
                CustomPaint(
                  size: const Size(160, 160),
                  painter: _CirclePainter(
                    progress: progress,
                    strokeWidth: 14,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF3FA9F5), Color(0xFF0A4DA2)],
                    ),
                    isBackground: false,
                  ),
                ),

                // Inner circle with play/pause gesture
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(1, 1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RepaintBoundary(
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Image.asset(
                                getTreeImage(progress),
                                fit: BoxFit.cover,
                                package: widget.assetPackage,
                                gaplessPlayback: true,
                                errorBuilder: (context, error, stackTrace) {
                                  final assetPath = getTreeImage(progress);
                                  debugPrint(
                                    'Failed to load asset: $assetPath (package=${widget.assetPackage}) -> $error',
                                  );
                                  return const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "$percentage%",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0A4DA2),
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "+${widget.pointsRemaining} points more",
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0XFF83848B),
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Trees Planted ${widget.treesPlanted}",
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF083F8B),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Gradient gradient;
  final bool isBackground;

  _CirclePainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradient,
    this.isBackground = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arcRect = rect.deflate(strokeWidth / 2);
    final startAngle = -3.14 / 2;
    final sweepAngle = 2 * 3.14 * progress;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..shader = gradient.createShader(rect);

    canvas.drawArc(arcRect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
