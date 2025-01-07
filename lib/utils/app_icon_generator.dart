import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AppIconGenerator {
  static Future<void> generateIcon() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(1024, 1024);
    
    // Background
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        [
          const Color(0xFF1A237E), // Indigo dark
          const Color(0xFF3949AB), // Indigo
        ],
      );
    
    canvas.drawRect(Offset.zero & size, paint);
    
    // Book icon
    final bookPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.2)
      ..lineTo(size.width * 0.75, size.height * 0.2)
      ..lineTo(size.width * 0.75, size.height * 0.8)
      ..lineTo(size.width * 0.25, size.height * 0.8)
      ..close();
    
    canvas.drawPath(
      bookPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill
    );
    
    // Pages
    final pagesPath = Path()
      ..moveTo(size.width * 0.35, size.height * 0.3)
      ..lineTo(size.width * 0.65, size.height * 0.3)
      ..lineTo(size.width * 0.65, size.height * 0.4)
      ..lineTo(size.width * 0.35, size.height * 0.4)
      ..close();
    
    canvas.drawPath(
      pagesPath,
      Paint()
        ..color = const Color(0xFFE8EAF6)
        ..style = PaintingStyle.fill
    );
    
    // Text lines
    for (var i = 0; i < 3; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * 0.35,
            size.height * (0.5 + i * 0.1),
            size.width * 0.3,
            size.height * 0.05,
          ),
          const Radius.circular(10),
        ),
        Paint()
          ..color = const Color(0xFFE8EAF6)
          ..style = PaintingStyle.fill,
      );
    }
    
    final picture = recorder.endRecording();
    final img = await picture.toImage(1024, 1024);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData != null) {
      // Save the image
      // Note: In actual implementation, you would need to use platform-specific code
      // to save the file to the assets/icon directory
    }
  }
} 