
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;

  const MyImage({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
