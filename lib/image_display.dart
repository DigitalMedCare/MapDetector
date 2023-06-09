import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ImageDisplayPage extends StatelessWidget {
  const ImageDisplayPage({Key? key, required this.paintedImage})
      : super(key: key);
  final File paintedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painted Image'),
      ),
      body: Center(
        child: Image.file(paintedImage),
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image paintedImage;

  ImagePainter(this.paintedImage);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(paintedImage, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
